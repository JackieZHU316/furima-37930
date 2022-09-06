class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :status_id, :charge_type_id, :region_id, :delivery_time_id,
                                 :price, :image).merge(user_id: current_user.id)
  end
end
