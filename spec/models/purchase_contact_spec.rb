require 'rails_helper'

RSpec.describe PurchaseContact, type: :model do
  describe '商品購入機能_商品配送先登録' do
    before do
      user = FactoryBot.create(:user)
      @purchase_contact = FactoryBot.build(:purchase_contact, user_id: user.id)
    end

    context '商品配送先登録できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_contact).to be_valid
      end
    end

    context '商品配送先登録できないとき' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_contact.post_code = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号がハイフンを持ってないと保存できないこと' do
        @purchase_contact.post_code = '3321110'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '郵便番号が「2桁ハイフン4桁」だと保存できないこと' do
        @purchase_contact.post_code = '33-1110'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '郵便番号が「3桁ハイフン3桁」だと保存できないこと' do
        @purchase_contact.post_code = '333-111'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '郵便番号が全角文字列だと保存できないこと' do
        @purchase_contact.post_code = '３３３-１１１０'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it '都道府県が空だと保存できないこと' do
        @purchase_contact.region_id = 1
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Region can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_contact.city = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @purchase_contact.house_number = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_contact.phone_number = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁の半角数値だと保存できないこと' do
        @purchase_contact.phone_number = 123456789
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Phone number is invalid. You cannot include hyphen(-)")
      end
      it '電話番号が12桁の半角数値だと保存できないこと' do
        @purchase_contact.phone_number = 123456789012
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Phone number is invalid. You cannot include hyphen(-)")
      end
      it '電話番号が10桁以上11桁以内の全角数値だと保存できないこと' do
        @purchase_contact.phone_number = '１２３４５６７８９０１'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Phone number is invalid. You cannot include hyphen(-)")
      end
      it '電話番号がハイフンを付けると保存できないこと' do
        @purchase_contact.phone_number = '080-1234-5678'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("Phone number is invalid. You cannot include hyphen(-)")
      end
    end
  end
end
