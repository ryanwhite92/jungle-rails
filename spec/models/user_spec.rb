require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let (:user) { User.new(first_name: 'Elliot', last_name: 'Alderson', email: 'alderson@fsociety.com') }

    context 'must be created with password and password_confirmation fields' do
      it 'should return error message if password is empty' do
        user.save
        expect(user.errors.full_messages.first).to eql('Password can\'t be blank')
      end

      it 'should return error message if password_confirmation is empty' do
        user.update(password: 'robot')
        expect(user.errors.full_messages.first).to eql('Password confirmation can\'t be blank')
      end

      it 'should be equal if password and password_confirmation fields match' do
        user.update(password: 'robot', password_confirmation: 'robot')
        expect(user.password).to eql(user.password_confirmation)
      end

      it 'should not be equal if password and password_confirmation do not match' do
        user.update(password: 'robot', password_confirmation: 'mrrobot')
        expect(user.password).to_not eql(user.password_confirmation)
      end
    end
  end
end
