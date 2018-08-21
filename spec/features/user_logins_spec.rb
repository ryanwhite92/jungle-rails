require 'rails_helper'

RSpec.feature "Visitor navigates to login page", type: :feature, js: true do

  before :each do
    @user = User.create!(
      first_name: 'First',
      last_name: 'Last',
      email: 'first@last.com',
      password: 'test1234',
      password_confirmation: 'test1234'
    )
  end

  scenario 'given valid credentials they are logged in' do
    visit login_path

    within 'form' do
      fill_in :email, with: 'first@last.com'
      fill_in :password, with: 'test1234'

      click_button 'Login'
    end

    expect(page).to have_content("Signed in as #{@user.first_name}")
  end

end
