require "order"
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
    end
  end
end
