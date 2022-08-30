require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
      user = User.new(nickname: '', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空だと登録できない' do
      user = User.new(nickname: 'jackie', email: '', password: 'aaa111', password_confirmation: 'aaa111', first_name: '一郎',
                      last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailが重複になると登録できない' do
      registed_user = User.new(nickname: 'jackie', email: 'test@test.com', password: 'aaa111', password_confirmation: 'aaa111',
                               first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user = User.new(nickname: 'tommy', email: 'test@test.com', password: 'aaa222', password_confirmation: 'aaa222',
                      first_name: '一郎', last_name: '山上', first_name_kana: 'イチロウ', last_name_kana: 'ヤマカミ', birthday_date: '1931-01-01 00:00:00')
      registed_user.save
      user.email = registed_user.email
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailで@がないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkkgmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが空だと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: '', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Password can't be blank", 'Password is invalid',
                                                   "Password confirmation doesn't match Password")
    end
    it 'passwordが6文字以上ではないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa11', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password",
                                                   'Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角英数字混合ではないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('Password is invalid')
    end
    it 'password confirmationがpasswordと違うと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa112',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前の名が空だと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
    end
    it 'お名前の姓が空だと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
    end
    it 'お名前の名が全角（漢字・ひらがな・カタカナ）ではないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: 'ichiro', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('First name is invalid')
    end
    it 'お名前の姓が全角（漢字・ひらがな・カタカナ）ではないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: 'yamashita', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('Last name is invalid')
    end

    it 'お名前の姓カナ(全角)が空だと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: '', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
    end
    it 'お名前の名カナ(全角)が空だと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: '', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
    end
    it 'お名前の姓カナ(全角)は全角（カタカナ）ではないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ﾔﾏｼﾀ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('Last name kana is invalid')
    end
    it 'お名前の名カナ(全角)は全角（カタカナ）ではないと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'ｲﾁﾛｳ', last_name_kana: 'ヤマシタ', birthday_date: '1930-01-01 00:00:00')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include('First name kana is invalid')
    end

    it '生年月日が空だと登録できない' do
      user = User.new(nickname: 'jackie', email: 'kkk@gmail.com', password: 'aaa111', password_confirmation: 'aaa111',
                      first_name: '一郎', last_name: '山下', first_name_kana: 'イチロウ', last_name_kana: 'ヤマシタ', birthday_date: '')
      user.valid?
      # binding.pry
      expect(user.errors.full_messages).to include("Birthday date can't be blank")
    end
  end
end
