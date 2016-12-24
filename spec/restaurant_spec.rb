require "restaurant"
describe Restaurant do
  describe "#initialize" do
    context "given valid options hash" do
      it "returns true" do
        valid_options_hash = Hash.new
        restaurant = Restaurant.new(valid_options_hash)
        expect(restaurant.options_hash_valid?).to eql(true)
      end
    end
  end
end
