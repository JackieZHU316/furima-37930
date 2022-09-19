class PurchaseContact
  include ActiveModel::Model
  attr_accessor :post_code, :region_id, :city, :house_number, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :house_number
    validates :phone_number
    validates :user_id
    validates :item_id
  end
  validates :region_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    # 各テーブルにデータを保存する処理を書く
  end

end