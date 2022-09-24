class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # 全角ひらがな、全角カタカナ、漢字
  ZENKAKU_REGEXP = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  ZENKAKU_KATAKANA_REGEXP = /\A[\p{katakana}ー－&&[^ -~｡-ﾟ]]+\z/

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: ZENKAKU_REGEXP }
  validates :first_name, presence: true, format: { with: ZENKAKU_REGEXP }
  validates :last_name_kana, presence: true, format: { with: ZENKAKU_KATAKANA_REGEXP }
  validates :first_name_kana, presence: true, format: { with: ZENKAKU_KATAKANA_REGEXP }
  validates :birthday_date, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  has_many :items
  has_many :purchases
end
