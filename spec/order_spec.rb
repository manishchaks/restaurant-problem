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

        #order is important.
        five_star_restaurant = restaurants_by_rating[0]
        four_star_restaurant = restaurants_by_rating[1]
        three_star_restaurant = restaurants_by_rating[2]

        expect(five_star_restaurant.rating).to eql(5)
        expect(five_star_restaurant.name).to eql("five star restaurant")

        expect(four_star_restaurant.rating).to eql(4)
        expect(four_star_restaurant.name).to eql("four star restaurant")

        expect(three_star_restaurant.rating).to eql(3)
        expect(three_star_restaurant.name).
          to eql("three star restaurant")

      end

      it "should be able to process orders given valid restaurants and order line items" do

        #Team needs: total 50 meals including 5 vegetarians and 7 gluten free.
        # Splitting into line items for Order
        # 5 vegetarians
        # 7 gluten-free
        # 38 regular

        order = Order.new
        five_veg_line_items = Hash.new
        five_veg_line_items[:vegetarian] = 5

        seven_gluten_free_line_items = Hash.new
        seven_gluten_free_line_items[:gluten_free] = 7

        thirty_eight_regular_items = Hash.new
        thirty_eight_regular_items[:regular] = 38

        # Check and add line items to order
        expect{order.add_line_item(five_veg_line_items)}.to_not raise_error
        expect{order.add_line_item(seven_gluten_free_line_items)}.to_not raise_error
        expect{order.add_line_item(thirty_eight_regular_items)}.to_not raise_error

        # create options for different types of meals
        vegetarian_meal_options = Hash.new
        vegetarian_meal_options[:vegetarian] = true
        vegetarian_meal_options[:gluten_free] = false
        vegetarian_meal_options[:fish_free] = true
        vegetarian_meal_options[:regular] = false

        gluten_free_meal_options = Hash.new
        gluten_free_meal_options[:gluten_free] = true
        gluten_free_meal_options[:vegetarian] = false
        gluten_free_meal_options[:fish_free] = false
        gluten_free_meal_options[:regular] = false

        regular_meal_options = Hash.new
        regular_meal_options[:regular] = true
        regular_meal_options[:gluten_free] = false
        regular_meal_options[:vegetarian] = false
        regular_meal_options[:fish_free] = false


        #Restaurant A has a rating of 5/5 and can serve 40 meals including 4 vegetarians,
        restaurant_A_options = Hash.new
        restaurant_A_options[:rating] = 5
        restaurant_A_options[:name] = "RestaurantA"
        restaurantA = Restaurant.new(restaurant_A_options)
        restaurantA.add_meals(Meal.bulk_create(vegetarian_meal_options,4))
        restaurantA.add_meals(Meal.bulk_create(regular_meal_options,36))

        expect(restaurantA.meals.size).to eq(40)

        #Restaurant B has a rating of 3/5 and can serve 100 meals
        #including 20 vegetarians, and 20 gluten free.
        restaurant_B_options = Hash.new
        restaurant_B_options[:rating] = 3
        restaurant_B_options[:name] = "RestaurantB"
        restaurantB = Restaurant.new(restaurant_B_options)
        restaurantB.add_meals(Meal.bulk_create(vegetarian_meal_options,20))
        restaurantB.add_meals(Meal.bulk_create(gluten_free_meal_options,20))
        restaurantB.add_meals(Meal.bulk_create(regular_meal_options,60))

        expect(restaurantB.meals.size).to eq(100)


        #Add restaurants to order
        order.add_restaurant(restaurantA)
        order.add_restaurant(restaurantB)
        order.process

        # Construct Hash of expected results
        #Expected meal orders: Restaurant A (4 vegetarian + 36 others), Restaurant B (1 vegetarian + 7 gluten free + 2 others)



      end
    end
  end
end
