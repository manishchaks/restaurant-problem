require "meal"
describe Meal do
  describe "#initialize" do
    context "a vegetarian meal" do
      it "must be fish free" do
        non_fish_free_meal = Hash.new
        non_fish_free_meal[:is_vegetarian] = true
        non_fish_free_meal[:is_gluten_free] = false
        non_fish_free_meal[:is_fish_free] = false
        meal = Meal.new(non_fish_free_meal)
        expect(meal.options_hash_valid?).to eql(false)

        fish_free_meal = Hash.new
        fish_free_meal[:is_vegetarian] = true
        fish_free_meal[:is_gluten_free] = false
        fish_free_meal[:is_fish_free] = true
        meal = Meal.new(fish_free_meal)
        expect(meal.options_hash_valid?).to eql(true)
      end
    end
    context "a fish free meal" do
      it "may be vegetarian" do
        fish_free_vegetarian_meal_hash = Hash.new
        fish_free_vegetarian_meal_hash[:is_vegetarian] = true
        fish_free_vegetarian_meal_hash[:is_gluten_free] = false
        fish_free_vegetarian_meal_hash[:is_fish_free] = true
        meal = Meal.new(fish_free_vegetarian_meal_hash)
        expect(meal.options_hash_valid?).to eql(true)
      end
      it "may not be vegetarian" do
        fish_free_non_vegetarian_meal_hash = Hash.new
        fish_free_non_vegetarian_meal_hash[:is_vegetarian] = false
        fish_free_non_vegetarian_meal_hash[:is_gluten_free] = false
        fish_free_non_vegetarian_meal_hash[:is_fish_free] = true
        meal = Meal.new(fish_free_non_vegetarian_meal_hash)
        expect(meal.options_hash_valid?).to eql(true)
      end
      # it "may be gluten free" do
      # end
      # it "may not be gluten free" do
      # end
    end
    context "a valid regular meal" do
      it "must not be fish free, gluten free or vegetarian" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:is_regular] = true
        regular_meal_hash[:is_vegetarian] = false
        regular_meal_hash[:is_gluten_free] = false
        regular_meal_hash[:is_fish_free] = false
        meal = Meal.new(regular_meal_hash)
        expect(meal.options_hash_valid?).to eql(true)
      end



      # it "must not be gluten free" do
      # end
      # it "must not be vegetarian" do
      # end
    end
    context "a meal which is regular and gluten free" do
      it "must be invalid" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:is_regular] = true
        regular_meal_hash[:is_gluten_free] = true
        meal = Meal.new(regular_meal_hash)
        expect(meal.options_hash_valid?).to eql(false)
      end
    end
    context "a meal which is regular and vegetarian" do
      it "must be invalid" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:is_regular] = true
        regular_meal_hash[:is_vegetarian] = true
        meal = Meal.new(regular_meal_hash)
        expect(meal.options_hash_valid?).to eql(false)
      end
    end
    context "a meal which is regular and fish free" do
      it "must be invalid" do
        regular_meal_hash = Hash.new
        regular_meal_hash[:is_regular] = true
        regular_meal_hash[:is_fish_free] = true
        meal = Meal.new(regular_meal_hash)
        expect(meal.options_hash_valid?).to eql(false)
      end
    end
  end
end
