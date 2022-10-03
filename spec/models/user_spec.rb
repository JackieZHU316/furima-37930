require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'emailが重複になると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailで@がないと登録できない' do
        @user.email = 'testexample'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが6文字以上ではないと登録できない' do
        @user.password = 'aaa11'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが半角数字のみだと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが全角だと登録できない' do
        @user.password = '１１１１１１'
        @user.password_confirmation = '１１１１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'password confirmationがpasswordと違うと登録できない' do
        @user.password_confirmation = 'aaa222'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'お名前の名が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名（全角）を入力してください")
      end
      it 'お名前の姓が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（全角）を入力してください")
      end
      it 'お名前の名が全角（漢字・ひらがな・カタカナ）ではないと登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（全角）は不正な値です')
      end
      it 'お名前の姓が全角（漢字・ひらがな・カタカナ）ではないと登録できない' do
        @user.last_name = 'bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（全角）は不正な値です')
      end

      it 'お名前の姓カナ(全角)が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓カナ（全角）を入力してください")
      end
      it 'お名前の名カナ(全角)が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名カナ（全角）を入力してください")
      end
      it 'お名前の姓カナ(全角)は全角（カタカナ）ではないと登録できない' do
        @user.last_name_kana = 'ﾔﾏｼﾀ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓カナ（全角）は不正な値です')
      end
      it 'お名前の名カナ(全角)は全角（カタカナ）ではないと登録できない' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名カナ（全角）は不正な値です')
      end

      it '生年月日が空だと登録できない' do
        @user.birthday_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationとお名前の名、お名前の姓、お名前の名カナ、お名前の姓カナと生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
  end
end
