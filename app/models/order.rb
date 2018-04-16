class Order < ApplicationRecord
  validates :user_id, presence: true
  has_many :order_accessories
  belongs_to :user

  enum status: %w[ordered completed paid cancelled]

  def self.status_total(status)
    where(status: status).count
  end

  def total_price
    order_accessories.map do |order_accessory|
      order_accessory.accessory.price * order_accessory.quantity
    end.sum
  end
end
