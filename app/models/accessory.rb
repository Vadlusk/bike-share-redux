class Accessory < ApplicationRecord
  validates_presence_of :title, :description
  enum status: ['active', 'retired']

  def active?
    return true if status == 'active'
    return false if status == 'retired'
  end
end
