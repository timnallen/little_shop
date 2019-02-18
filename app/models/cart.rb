class Cart
  attr_reader :contents

  def initialize(contents=Hash.new(0))
    @contents = contents
  end

  def total_count
    @contents.sum do |item_id, info|
      info["quantity"].to_i
    end
  end

  def add_item(id, price)
    if @contents[id].class == Hash
      quantity = (@contents[id]["quantity"].to_i + 1).to_s
    else
      quantity = "1"
    end
    @contents[id] = {"unit_price" => price, "quantity" => quantity}
  end

  def total
    @contents.sum do |item, info|
      Item.find(item).price * info["quantity"].to_i
    end
  end
end
