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

  def total_item_count
    contents.values.sum
  end
end
