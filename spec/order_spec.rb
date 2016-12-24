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
        expect{order.add_line_item(line_item_hash)}.to_not raise_error
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

    context "Restaurant processing" do
      it "Should be able to arrange restaurants in descending order of rating, given multiple restaurants" do
        valid_meal = Hash.new
        valid_meal[:vegetarian] = true
        valid_meal[:gluten_free] = false
        valid_meal[:fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        order = Order.new

        restaurant_with_4_star_rating = Hash.new
        restaurant_with_4_star_rating[:rating] = 4
        restaurant_with_4_star_rating[:name] = "four star restaurant"
        restaurant_with_4_star_rating[:meals] = meals
        restaurant = Restaurant.new(restaurant_with_4_star_rating)
        order.add_restaurant(restaurant)


        restaurant_with_5_star_rating = Hash.new
        restaurant_with_5_star_rating[:rating] = 5
        restaurant_with_5_star_rating[:name] = "five star restaurant"
        restaurant_with_5_star_rating[:meals] = meals
        restaurant = Restaurant.new(restaurant_with_5_star_rating)
        order.add_restaurant(restaurant)

        restaurant_with_3_star_rating = Hash.new
        restaurant_with_3_star_rating[:rating] = 3
        restaurant_with_3_star_rating[:name] = "three star restaurant"
        restaurant_with_3_star_rating[:meals] = meals
        restaurant = Restaurant.new(restaurant_with_3_star_rating)
        order.add_restaurant(restaurant)

        expect(order.restaurants.size).to eql(3)

        restaurants_by_rating = order.sort_restaurants_by_rating
        five_star_restaurant = restaurants_by_rating[0]
        four_star_restaurant = restaurants_by_rating[1]
        three_star_restaurant = restaurants_by_rating[2]

        expect(five_star_restaurant.rating).to eql(5)
        expect(five_star_restaurant.name).to eql("five star restaurant")

        expect(four_star_restaurant.rating).to eql(4)
        expect(four_star_restaurant.name).to eql("four star restaurant")

        expect(three_star_restaurant.rating).to eql(3)
        expect(three_star_restaurant.name).to eql("three star restaurant")

      end
    end
  end
end
