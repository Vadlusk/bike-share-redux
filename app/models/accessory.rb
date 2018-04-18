class Accessory < ApplicationRecord
  validates_presence_of :title, :description, :price
  validates_uniqueness_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0

  has_many :order_accessories, dependent: :destroy
  has_many :order_accessories

  enum status: ['active', 'retired']

  def subtotal(count_in_cart)
    price * count_in_cart
  end
end
