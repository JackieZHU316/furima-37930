class Item < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }, presence: true
  validates :status_id, numericality: { other_than: 1, message: "can't be blank" }, presence: true
  validates :charge_type_id, numericality: { other_than: 1, message: "can't be blank" }, presence: true
  validates :region_id, numericality: { other_than: 1, message: "can't be blank" }, presence: true
  validates :delivery_time_id, numericality: { other_than: 1, message: "can't be blank" }, presence: true
  validates :price, presence: true


  # belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :statu
  belongs_to :charge_type
  belongs_to :region
  belongs_to :delivery_time

end
