class Accessory < ApplicationRecord
  validates_presence_of :title, :description
  has_many :order_accessories, dependent: :destroy
  enum status: ['active', 'retired']

  def active?
    return true if status == 'active'
    return false if status == 'retired'
  end

  def subtotal(count_in_cart)
    price * count_in_cart
  end

  def activate
    self.status = 0
  end

  def deactivate
    self.status = 1
  end
end
