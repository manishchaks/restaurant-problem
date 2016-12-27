require 'meal'
class Order
  attr_reader :line_items, :restaurants
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

  def sort_restaurants_by_rating
    @sorted_restaurants = @restaurants.sort_by { |restaurant| restaurant.rating }.reverse!
    @sorted_restaurants
  end

  def process
    processed_hash =  create_skeleton_processed_hash
    sort_restaurants_by_rating.each do |restaurant|
      processed_items = 0
      @line_items.each do |line_item|
        processed_items = restaurant.process_line_item(line_item)
        processed_hash[restaurant.name][line_item.keys[0]] =
          processed_hash[restaurant.name][line_item.keys[0]] + processed_items
      end
      remove_used_line_items(processed_hash[restaurant.name])
    end
    processed_hash
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
    processed_hash
  end

  def remove_used_line_items processed_hash
    # Line items are    [{:vegetarian=>5}, {:gluten_free=>7}, {:regular=>38}]
    # processed_hash is {:regular=>36, :fish_free=>0, :gluten_free=>0, :vegetarian=>4}
    processed_hash.keys.each do |key|
      value = processed_hash[key]
      #puts "Key: #{key} / Value : #{value}"
      @line_items.each do |line_item|
        #puts "At line item" + line_item.to_s
        if(line_item.has_key?(key))
          line_item[key] = line_item[key] - value
        end
      end
      #puts "updated line items: #{@line_items}"
    end
  end
end
