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

  def process
    processed_hash =  create_skeleton_processed_hash
    processed_items = 0
    sort_restaurants_by_rating.each do |restaurant|
      @line_items.each do |line_item|
        processed_items = restaurant.process_line_item(line_item)
        processed_hash[restaurant.name][line_item.keys[0]] =
        processed_hash[restaurant.name][line_item.keys[0]] +
        processed_items
      end
    end
    puts processed_hash.to_s
  end

  private
  def create_skeleton_processed_hash
    processed_hash = Hash.new { |hash, key| hash[key] = {} }
    sort_restaurants_by_rating.each do | restaurant|
      restaurant_hash = Hash.new
      processed_hash[restaurant.name]
      Meal.acceptable_types.each do |meal_type|
        processed_hash[restaurant.name][meal_type] = 0
      end
    end
    puts processed_hash
    processed_hash
  end
end
