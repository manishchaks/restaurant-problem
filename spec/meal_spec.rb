require "meal"
describe Meal do
  describe "#initialize" do
    context "a vegetarian meal" do
      it "must be fish free" do
        meal_options_hash = Hash.new
        meal_options_hash[:is_vegetarian] = true
        meal_options_hash[:is_gluten_free] = false
        meal_options_hash[:is_fish_free] = true
        meal = Meal.new(meal_options_hash)
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
  end
end
