class Order < ApplicationRecord
  validates :user_id, presence: true
  has_many :order_accessories
  belongs_to :user

  enum status: %w[ordered completed paid cancelled]
end
