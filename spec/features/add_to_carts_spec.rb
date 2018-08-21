require 'rails_helper'

RSpec.feature "Users click add to cart button", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'Cart increases by one' do
    visit root_path

    cart = find("a[href='#{cart_path}']")

    expect(cart.text).to have_content('My Cart (0)')

    first('article.product').click_on('Add')

    expect(cart.text).to have_content('My Cart (1)')
  end

end
