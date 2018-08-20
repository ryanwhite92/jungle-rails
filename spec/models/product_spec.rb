require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      category = Category.new(name: 'Drones')
      product = Product.new(name: 'Stealth Drone', price: 120000, quantity: 8, category: category)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      category = Category.new(name: 'Drones')
      product = Product.new(name: nil, price: 120000, quantity: 8, category: category)
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      category = Category.new(name: 'Drones')
      product = Product.new(name: 'Stealth Drone', price: nil, quantity: 8, category: category)
      expect(product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      category = Category.new(name: 'Drones')
      product = Product.new(name: 'Stealth Drone', price: 120000, quantity: nil, category: category)
      expect(product).to_not be_valid
    end

    it 'is not valid without a category' do
      category = Category.new(name: 'Drones')
      product = Product.new(name: 'Stealth Drone', price: 120000, quantity: 8, category: nil)
      expect(product).to_not be_valid
    end
  end
end
