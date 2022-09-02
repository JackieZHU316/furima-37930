class Item < ApplicationRecord
  # validates :name, presence: true
  # validates :introduction, presence: true
  # validates :category_id, presence: true
  # validates :status_id, presence: true
  # validates :charge_type_id, presence: true
  # validates :region_id, presence: true
  # validates :delivery_time_id, presence: true
  # validates :price, presence: true

  # belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
