class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :confirm_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
     @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find_by(params[:id])
  end

  def confirm_user
    redirect_to root_path unless current_user.id == @item
  end

end
