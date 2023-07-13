class ItemsController < ApplicationController
  def index
    #@items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

end
