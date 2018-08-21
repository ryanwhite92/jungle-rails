require 'rails_helper'

RSpec.feature "Visitors navigates to product detail page", type: :feature, js: true do

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

  scenario 'They see product detail' do
    visit root_path

    first('article.product').click_on('Details')

    # First product on page was created last
    expect(page).to have_content("#{@category.name} » #{@category.products.last.name}")
  end
end
