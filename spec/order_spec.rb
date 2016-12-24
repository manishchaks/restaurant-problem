require "order"
require "restaurant"
require "meal"
describe Order do
  describe "#add_line_item" do
    context "adding a line item to an order" do
      it "should accept with valid number and food type" do
        order = Order.new
        line_item_hash = Hash.new
        line_item_hash[:regular] = 10
        order.add_line_item(line_item_hash)
        expect(order.line_items.size).to eql(1)
      end
      it "should raise an exception if line item does not specify valid food type" do
        order = Order.new
        line_item_hash = Hash.new
        line_item_hash[:foo] = 10
        expect {order.add_line_item(line_item_hash)}.to raise_error(RuntimeError,'Food type can only be one of [:regular, :fish_free, :gluten_free, :vegetarian]')
      end
    end

    context "Adding a restaurant to an order" do
      it "should accept a valid restaurant without error" do
        valid_meal = Hash.new
        valid_meal[:vegetarian] = true
        valid_meal[:gluten_free] = false
        valid_meal[:fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        order = Order.new

        expect{order.add_restaurant(restaurant)}.to_not raise_error
        expect(order.restaurants.size).to eql(1)
      end
    end
  end
end
