class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    if @item.user_id == current_user.id || @item.purchase != nil
      redirect_to root_path
    end
    @purchase_rooms = PurchaseRooms.new
  end
  
  def create
    @purchase_rooms = PurchaseRooms.new(purchase_params)
    
    if @purchase_rooms.valid?
      pay_item
      @purchase_rooms.save
      redirect_to root_path
    else
      render :index
    end
  end

  def purchase_params
    params.require(:purchase_rooms).permit(:post_code, :prefecture_id, :municipalities, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
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