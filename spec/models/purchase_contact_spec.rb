require 'rails_helper'

RSpec.describe PurchaseContact, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_contact = FactoryBot.build(:purchase_contact, user_id: user.id, item_id: item.id)
      sleep(0.1)
    end

    context '商品配送先登録できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_contact).to be_valid
      end
      it '建物名を入力しなくても保存できること' do
        @purchase_contact.building = ''
        expect(@purchase_contact).to be_valid
      end
    end

    context '商品配送先登録できないとき' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_contact.post_code = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号がハイフンを持ってないと保存できないこと' do
        @purchase_contact.post_code = '3321110'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('郵便番号は不正な値です。ハイフン(-)を入れてください')
      end
      it '郵便番号が「2桁ハイフン4桁」だと保存できないこと' do
        @purchase_contact.post_code = '33-1110'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('郵便番号は不正な値です。ハイフン(-)を入れてください')
      end
      it '郵便番号が「3桁ハイフン3桁」だと保存できないこと' do
        @purchase_contact.post_code = '333-111'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('郵便番号は不正な値です。ハイフン(-)を入れてください')
      end
      it '郵便番号が全角文字列だと保存できないこと' do
        @purchase_contact.post_code = '３３３-１１１０'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('郵便番号は不正な値です。ハイフン(-)を入れてください')
      end
      it '都道府県が空だと保存できないこと' do
        @purchase_contact.region_id = 1
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_contact.city = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地が空だと保存できないこと' do
        @purchase_contact.house_number = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_contact.phone_number = ''
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号が9桁の半角数値だと保存できないこと' do
        @purchase_contact.phone_number = 123_456_789
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('電話番号は不正な値です。ハイフン(-)を入れないでください')
      end
      it '電話番号が12桁の半角数値だと保存できないこと' do
        @purchase_contact.phone_number = 123_456_789_012
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('電話番号は不正な値です。ハイフン(-)を入れないでください')
      end
      it '電話番号が10桁以上11桁以内の全角数値だと保存できないこと' do
        @purchase_contact.phone_number = '１２３４５６７８９０１'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('電話番号は不正な値です。ハイフン(-)を入れないでください')
      end
      it '電話番号がハイフンを付けると保存できないこと' do
        @purchase_contact.phone_number = '080-1234-5678'
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include('電話番号は不正な値です。ハイフン(-)を入れないでください')
      end
    end

    context 'クレジットカード決済できるとき' do
      it 'すべて必要な情報があれば保存ができること' do
        expect(@purchase_contact).to be_valid
      end
    end

    context 'クレジットカード決済できないとき' do
      it 'userが紐付いていなければ保存できないこと' do
        @purchase_contact.user_id = nil
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'itemが紐付いていなければ保存できないこと' do
        @purchase_contact.item_id = nil
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("商品を入力してください")
      end
      it 'tokenが空では保存できないこと' do
        @purchase_contact.token = nil
        @purchase_contact.valid?
        expect(@purchase_contact.errors.full_messages).to include("クレジットカード情報を正しく入力してください")
      end
    end
  end
end
