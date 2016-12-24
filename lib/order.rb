require 'meal'
class Order
  def initialize
    @restaurants = Array.new
    @line_items = Array.new
  end

  def add_line_item line_item_as_hash
    error_message = "Food type can only be one of #{Meal.acceptable_types.to_s}"
    raise error_message unless Meal.acceptable_types.any? {|k| line_item_as_hash.key?(k)}
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
