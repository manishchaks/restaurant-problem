require "meal"
describe Meal do
  describe "#initialize" do
    context "given valid options hash" do
      it "returns true" do
        valid_options_hash = Hash.new
        meal = Meal.new(valid_options_hash)
        expect(meal.options_hash_valid?).to eql(true)
      end
    end
  end
end
