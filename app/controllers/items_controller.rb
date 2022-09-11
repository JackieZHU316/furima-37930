class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order('created_at DESC')
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      item = Item.find(params[:id])
      if current_user.id != item.user.id
        redirect_to root_path
      else
        @item = Item.find(params[:id])
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :status_id, :charge_type_id, :region_id, :delivery_time_id,
                                 :price, :image).merge(user_id: current_user.id)
  end
end
