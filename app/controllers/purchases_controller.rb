class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_shippings = PurchaseShippings.new
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def create
    @purchase_shippings = PurchaseShippings.new(purchase_params)
    if @purchase_shippings.valid?
      pay_item
      @purchase_shippings.save
      redirect_to root_path
    else
      render :index
    end
  end

  def purchase_params
    params.require(:purchase_shippings).permit(:post_code, :prefecture_id, :municipalities, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def set_item
    @item = Item.find_by(params[:id])
  end

  def pay_item
    Payjp.api_key = "sk_test_838fd4b9ae9301716b634e9a"
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end