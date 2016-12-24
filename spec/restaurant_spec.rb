require "restaurant"
describe Restaurant do
  describe "#initialize" do
    context "a Restaurant without meals" do
      it "must be invalid" do
        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.options_hash_valid?).to eql(false)
      end
    end
    context "a Restaurant without a rating" do
      it "must be invalid" do
        valid_meal = Hash.new
        valid_meal[:is_vegetarian] = true
        valid_meal[:is_gluten_free] = false
        valid_meal[:is_fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.options_hash_valid?).to eql(false)
      end
    end
    context "a Restaurant without a name" do
      it "must be invalid" do
        valid_meal = Hash.new
        valid_meal[:is_vegetarian] = true
        valid_meal[:is_gluten_free] = false
        valid_meal[:is_fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.options_hash_valid?).to eql(false)
      end
    end
    context "a Restaurant with  meals, rating and name" do
      it "is valid" do
        valid_meal = Hash.new
        valid_meal[:is_vegetarian] = true
        valid_meal[:is_gluten_free] = false
        valid_meal[:is_fish_free] = true
        meal = Meal.new(valid_meal)
        meals = Array.new
        meals << meal

        restaurant_options_hash = Hash.new
        restaurant_options_hash[:rating] = 4
        restaurant_options_hash[:name] = "test restaurant"
        restaurant_options_hash[:meals] = meals
        restaurant = Restaurant.new(restaurant_options_hash)

        expect(restaurant.options_hash_valid?).to eql(true)
      end
    end
  end
end
