class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to action: :index
      # binding.pry
    else
      render :new
      # binding.pry
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :status_id, :charge_type_id, :region_id, :delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end
end
