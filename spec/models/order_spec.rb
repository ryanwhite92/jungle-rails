require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    let(:drones) { Category.new(name: 'Drones') }
    let(:product1) { Product.create!(id: 1, name: 'Stealth Drone', price: 1500, quantity: 8, category: drones) }
    let(:product2) { Product.create!(id: 2, name: 'Camera Drone', price: 800, quantity: 22, category: drones) }
    let(:product3) { Product.create!(id: 3, name: 'Mini Drone', price: 500, quantity: 18, category: drones) }

    before :each do
      @order = Order.new(stripe_charge_id: 1)
      @order.line_items.new(product: product1, quantity: 1, item_price: product1.price, total_price: product1.price * 1)
      @order.line_items.new(product: product2, quantity: 2, item_price: product2.price, total_price: product2.price * 2)
      @order.total_cents = @order.line_items.reduce(0) { |sum, i| sum + i.total_price }

      @order.save!
    end

    it 'deducts quantity from products based on their line item quantities' do
      product1.reload
      product2.reload

      expect(product1.quantity).to eql(7)
      expect(product2.quantity).to eql(20)

    end

    it 'does not deduct quantity from products that are not in the order' do
      product3.reload

      expect(product3.quantity).to eql(18)
    end
  end
end
