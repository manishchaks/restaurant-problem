require 'meal'
class Order
  def initialize
    @restaurants = []
    @line_items = []
    @sorted_restaurants = []
  end

  def add_line_item line_item_as_hash
    error_message = "Food type can only be one of #{Meal.acceptable_types.to_s}"
    raise error_message unless Meal.acceptable_types.any? {|k| line_item_as_hash.key?(k)}
    @line_items << line_item_as_hash
  end

  def add_restaurant restaurant
    raise "Supplied restaurant is invalid" unless restaurant.valid?
    @restaurants << restaurant
  end

  def restaurants
    @restaurants
  end

  def line_items
    @line_items
  end

  def sort_restaurants_by_rating
    @sorted_restaurants = @restaurants.sort_by { |restaurant| restaurant.rating }.reverse!
    @sorted_restaurants
  end
end
