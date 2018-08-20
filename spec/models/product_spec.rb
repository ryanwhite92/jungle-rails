require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.new(name: 'Drones') }
    let(:product) { Product.new(name: 'Stealth Drone',
                                price: 1200,
                                quantity: 8,
                                category: category) }

    it 'is valid with valid attributes' do
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product.name = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product.price_cents = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      product.quantity = nil
      expect(product).to_not be_valid
    end

    it 'is not valid without a category' do
      product.category = nil
      expect(product).to_not be_valid
    end
  end
end
