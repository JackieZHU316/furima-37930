class PurchasesController < ApplicationController
  def index
    #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    @purchase_contact = PurchaseContact.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_contact = PurchaseContact.new(purchase_params)
    if @purchase_contact.valid?
      @purchase_contact.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_contact).permit(:post_code, :region_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
