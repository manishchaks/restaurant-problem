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
      it "should raise an exception if line item does not specify valid food type" do
        order = Order.new
        line_item_hash = Hash.new
        line_item_hash[:foo] = 10
        expect {order.add_line_item(line_item_hash)}.to raise_error(RuntimeError,'Food type can only be one of [:regular, :fish_free, :gluten_free, :vegetarian]')
      end
    end
  end
end
