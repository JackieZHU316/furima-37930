class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :set_purchases, only: [:index, :show, :edit]

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
    @item_purchased = false 
  end

  def edit
    redirect_to root_path if current_user.id != @item.user.id

    @purchases.each do |purchase|
      if @item.id == purchase.item_id
        redirect_to root_path
      end
    end
    
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user_id
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :status_id, :charge_type_id, :region_id, :delivery_time_id,
                                 :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_purchases 
    @purchases = Purchase.all
  end

end
