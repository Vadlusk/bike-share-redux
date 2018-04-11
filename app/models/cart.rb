class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def add_accessory(id)
    contents[id.to_s] = contents[id.to_s] + 1
  end
end
