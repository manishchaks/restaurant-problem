class Order
  def initialize
    @restaurants = Array.new
    @line_items = Array.new
    @acceptable_food_types = [:regular, :fish_free, :gluten_free, :vegetarian]
  end

  def add_line_item line_item_as_hash
    raise "Food type can only be one of #{@acceptable_food_types.to_s}" unless  @acceptable_food_types.any? {|k| line_item_as_hash.key?(k)}
    @line_items << line_item_as_hash
  end

  def add_restaurant restaurant
    raise "Supplied restaurant is invalid" unless restaurant.valid?
    @restaurants << restaurants
  end

  def restaurants
    @restaurants
  end

  def line_items
    @line_items
  end
end
