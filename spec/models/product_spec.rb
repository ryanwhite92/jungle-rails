require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.new(name: 'Drones') }
    let!(:product) { Product.new(name: 'Stealth Drone',
                                 price: 1200,
                                 quantity: 8,
                                 category: category) }

    context 'with valid attributes' do
      it 'should be valid' do
        expect(product).to be_valid
      end

      it 'should save product to database' do
        product.save
        expect(product.errors.full_messages.length).to eql(0)
      end
    end

    context 'without a valid name' do
      before { product.update(name: nil) }

      it 'should return a name error message' do
        expect(product.errors.full_messages.first).to eql('Name can\'t be blank')
      end
    end

    context 'without a valid price' do
      before { product.update(price_cents: nil) }

      it 'should return a price error message' do
        expect(product.errors.full_messages.first).to eql('Price cents is not a number')
      end
    end

    context 'without a valid quantity' do
      it 'should return a quantity error message' do
        product.update(quantity: nil)
        expect(product.errors.full_messages.first).to eql('Quantity can\'t be blank')
      end
    end

    context 'without a valid category' do
      it 'should return a category error message' do
        product.update(category: nil)
        expect(product.errors.full_messages.first).to eql('Category can\'t be blank')
      end
    end
  end
end
