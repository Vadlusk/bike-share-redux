class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def add_accessory(id)
    if contents.empty? || contents[id.to_s].nil?
      contents[id.to_s] = 1
    else
      contents[id.to_s] += 1
    end
  end

  def remove_accessory(id)
    @contents.delete(id)
  end

  def increment_accessory(id)
    @contents[id] += 1
  end

  def total_item_count
    contents.values.sum
  end

  def total_price
    @total_price ||= contents.map do |accessory, quantity|
      Accessory.find(accessory).price * quantity
    end.sum
  end

  def subtotal(accessory)
    accessory.price * contents[accessory.id.to_s]
  end
end
