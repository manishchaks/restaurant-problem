require "restaurant"
describe Restaurant do
  describe "#initialize" do
    context "a Restaurant without meals" do
      it "must be invalid" do
        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.valid?).to eql(false)
      end
    end
    context "a Restaurant without a rating" do
      it "must be invalid" do
        valid_meal = Hash.new
        valid_meal[:vegetarian] = true
        valid_meal[:gluten_free] = false
        valid_meal[:fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.valid?).to eql(false)
      end
    end
    context "a Restaurant without a name" do
      it "must be invalid" do
        valid_meal = Hash.new
        valid_meal[:vegetarian] = true
        valid_meal[:gluten_free] = false
        valid_meal[:fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.valid?).to eql(false)
      end
    end

    context "a Restaurant with  meals, rating and name" do
      it "is valid" do
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

        expect(restaurant.valid?).to eql(true)
      end
    end

    context "A restaurant being asked to fulfill a line item from an order" do
      it "should be able to fulfill 20 vegetarian meals from a total of 50 vegetarian and 50 regular meals" do
        line_item = {:vegetarian => 20}

        veg_meal = Hash.new
        veg_meal[:vegetarian] = true
        veg_meal[:gluten_free] = false
        veg_meal[:fish_free] = true
        veg_meal[:regular] = false
        meals = Meal.bulk_create(veg_meal,50)

        regular_meal = Hash.new
        regular_meal[:vegetarian] = false
        regular_meal[:gluten_free] = false
        regular_meal[:fish_free] = false
        regular_meal[:regular] = true
        meals = meals + Meal.bulk_create(regular_meal,50)


        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.process_line_item(line_item)).to eql(20)
      end

      it "should be able to fulfill 10 vegetarian meals from a total of 10 vegetarian and 50 regular meals for a given restaurant" do
        line_item = {:vegetarian => 10}

        veg_meal = Hash.new
        veg_meal[:vegetarian] = true
        veg_meal[:gluten_free] = false
        veg_meal[:fish_free] = true
        veg_meal[:regular] = false
        meals = Meal.bulk_create(veg_meal,10)

        regular_meal = Hash.new
        regular_meal[:vegetarian] = false
        regular_meal[:gluten_free] = false
        regular_meal[:fish_free] = false
        regular_meal[:regular] = true
        meals = meals + Meal.bulk_create(regular_meal,50)

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.process_line_item(line_item)).to eql(10)
      end
      it "given a line item for 10 vegetarian items and given a restaurant with 5 vegetarian items and 50 regular items, it should be able to fullfill the 5 items" do
        line_item = {:vegetarian => 10}

        veg_meal = Hash.new
        veg_meal[:vegetarian] = true
        veg_meal[:gluten_free] = false
        veg_meal[:fish_free] = true
        veg_meal[:regular] = false
        meals = Meal.bulk_create(veg_meal,5)

        regular_meal = Hash.new
        regular_meal[:vegetarian] = false
        regular_meal[:gluten_free] = false
        regular_meal[:fish_free] = false
        regular_meal[:regular] = true
        meals = meals + Meal.bulk_create(regular_meal,50)

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.process_line_item(line_item)).to eql(5)
      end
    end
  end
end
