require 'rails_helper'

RSpec.describe PurchaseContact, type: :model do
  describe '商品購入機能_クレジットカード決済' do
    before do
      user = FactoryBot.create(:user)
      @purchase = FactoryBot.build(:purchase_contact, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it "tokenがあれば保存ができること" do
        expect(@purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "tokenが空では登録できないこと" do
        @purchase.token = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end
    end

  end
end