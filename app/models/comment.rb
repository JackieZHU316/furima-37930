class Comment < ApplicationRecord
  validates :message, presence: true

  belongs_to :item
  belongs_to :user
end
