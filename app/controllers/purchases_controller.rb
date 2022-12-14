class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :purchase_item

  def index
    @purchases = Purchase.all
    if current_user.id != @item.user.id
      @purchase_contact = PurchaseContact.new
      @purchases.each do |purchase|
        redirect_to root_path if @item.id == purchase.item_id
      end
    else
      redirect_to root_path
    end
  end

  def create
    @purchase_contact = PurchaseContact.new(purchase_params)
    if @purchase_contact.valid?
      pay_item
      @purchase_contact.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_contact).permit(:post_code, :region_id, :city, :house_number, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def purchase_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: item[:price],
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
