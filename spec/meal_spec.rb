require "meal"
describe Meal do
  describe ".bulk_create" do
    context "bulk creation of meals (helper method" do
      it "should be able to create meals in bulk" do
        fish_free_meal = Hash.new
        fish_free_meal[:is_vegetarian] = true
        fish_free_meal[:gluten_free] = false
        fish_free_meal[:fish_free] = true

        meals = Meal.bulk_create(fish_free_meal,50)
        expect(meals.size).to eql(50)
      end
    end
  end

  describe "#initialize" do
    context "a vegetarian meal" do
      it "must be fish free" do
        fish_free_meal = Hash.new
        fish_free_meal[:is_vegetarian] = true
        fish_free_meal[:gluten_free] = false
        fish_free_meal[:fish_free] = true
        meal = Meal.new(fish_free_meal)
        expect(meal.valid?).to eql(true)
      end
      it "containing fish is invalid" do
        non_fish_free_meal = Hash.new
        non_fish_free_meal[:vegetarian] = true
        non_fish_free_meal[:gluten_free] = false
        non_fish_free_meal[:fish_free] = false
        meal = Meal.new(non_fish_free_meal)
        expect(meal.valid?).to eql(false)
      end
    end
    context "a fish free meal" do
      it "may be vegetarian" do
        fish_free_vegetarian_meal_hash = Hash.new
        fish_free_vegetarian_meal_hash[:vegetarian] = true
        fish_free_vegetarian_meal_hash[:gluten_free] = false
        fish_free_vegetarian_meal_hash[:fish_free] = true
        meal = Meal.new(fish_free_vegetarian_meal_hash)
        expect(meal.valid?).to eql(true)
      end
      it "may not be vegetarian" do
        fish_free_non_vegetarian_meal_hash = Hash.new
        fish_free_non_vegetarian_meal_hash[:vegetarian] = false
        fish_free_non_vegetarian_meal_hash[:gluten_free] = false
        fish_free_non_vegetarian_meal_hash[:fish_free] = true
        meal = Meal.new(fish_free_non_vegetarian_meal_hash)
        expect(meal.valid?).to eql(true)
      end
      # it "may be gluten free" do
      # end
      # it "may not be gluten free" do
      # end
    end
    context "a valid regular meal" do
      it "must not be fish free, gluten free or vegetarian" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:regular] = true
        regular_meal_hash[:vegetarian] = false
        regular_meal_hash[:gluten_free] = false
        regular_meal_hash[:fish_free] = false
        meal = Meal.new(regular_meal_hash)
        expect(meal.valid?).to eql(true)
      end
    end
    context "a meal which is regular and gluten free" do
      it "must be invalid" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:regular] = true
        regular_meal_hash[:gluten_free] = true
        meal = Meal.new(regular_meal_hash)
        expect(meal.valid?).to eql(false)
      end
    end
    context "a meal which is regular and vegetarian" do
      it "must be invalid" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:regular] = true
        regular_meal_hash[:vegetarian] = true
        meal = Meal.new(regular_meal_hash)
        expect(meal.valid?).to eql(false)
      end
    end
    context "a meal which is regular and fish free" do
      it "must be invalid" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:regular] = true
        regular_meal_hash[:fish_free] = true
        meal = Meal.new(regular_meal_hash)
        expect(meal.valid?).to eql(false)
      end
    end
  end
end
