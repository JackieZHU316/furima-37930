class PurchaseContact
  include ActiveModel::Model
  attr_accessor :post_code, :region_id, :city, :house_number, :building, :phone_number, :user_id, :item_id
end