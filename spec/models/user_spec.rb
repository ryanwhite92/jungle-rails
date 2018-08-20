require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let (:user) { User.new(first_name: 'Elliot',
                           last_name: 'Alderson',
                           email: 'alderson@fsociety.com') }

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

    context 'must be created with a unique email' do
      let (:user2) { User.new(first_name: 'Darlene',
                              last_name: 'Alderson',
                              password: 'mrrobot',
                              password_confirmation: 'mrrobot') }

      it 'should be invalid if email field is blank' do
        user2.save
        expect(user2).to_not be_valid
      end

      it 'should be invalid if registering with non-unique email' do
        user.update(email: 'alderson@fsociety.com')
        expect(user2).to_not be_valid
      end

      it 'should be case sensitive' do
        user2.update(email: 'ALDERSON@fsociety.com')
        expect(user.email).to_not eql(user2.email)
      end
    end
  end
end
