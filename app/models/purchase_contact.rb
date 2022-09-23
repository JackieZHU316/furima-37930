class PurchaseContact
  include ActiveModel::Model
  attr_accessor :post_code, :region_id, :city, :house_number, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}+-+[0-9]{4}+\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :house_number
    validates :phone_number, format: {with: /\A[0-9]{10,11}+\z/, message: "is invalid. You cannot include hyphen(-)"}
    validates :user_id
  end
  validates :region_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: @item_id)
    Contact.create(post_code: post_code, region_id: region_id, city: city, house_number: house_number, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end

end