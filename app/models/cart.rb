class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def total_count
    @contents.sum do |item_id, quantity|
      quantity.to_i
    end
  end

  def add_item(id)
    @contents[id] = (@contents[id].to_i + 1).to_s
  end

  def remove_item(id)
    current_quantity = @contents[id] = (@contents[id].to_i - 1).to_s
    @contents.delete(id) if current_quantity.to_i <= 0
  end

  def clear_item(id)
    @contents.delete(id)
  end

  def total
    @contents.sum do |item, quantity|
      Item.find(item).price * quantity.to_i
    end
  end
end
