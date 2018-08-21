require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let (:user) { User.new(first_name: 'First',
                           last_name: 'Last',
                           email: 'email@example.com') }

    context 'must be created with password and password_confirmation fields' do
      it 'should return error message if password is empty' do
        user.save
        expect(user.errors.full_messages.first).to eql('Password can\'t be blank')
      end

      it 'should return error if password is less than 8 characters long' do
        user.update(password: 'test')
        expect(user.errors.full_messages.first).to eql('Password is too short (minimum is 8 characters)')
      end

      it 'should return error message if password_confirmation is empty' do
        user.update(password: 'test1234')
        expect(user.errors.full_messages.first).to eql('Password confirmation can\'t be blank')
      end

      it 'should be equal if password and password_confirmation fields match' do
        user.update(password: 'test1234', password_confirmation: 'test1234')
        expect(user.password).to eql(user.password_confirmation)
      end

      it 'should not be equal if password and password_confirmation do not match' do
        user.update(password: 'test1234', password_confirmation: 'test123456')
        expect(user.password).to_not eql(user.password_confirmation)
      end
    end

    context 'must be created with a unique email' do
      it 'should be invalid if email field is blank' do
        user = User.create(first_name: 'Second', last_name: 'Last', password: 'guest1234', password_confirmation: 'guest1234')
        expect(user).to_not be_valid
      end

      it 'should be invalid if registering with non-unique email' do
        user = User.create(first_name: 'Second', last_name: 'Last', email: 'email@example.com', password: 'guest1234', password_confirmation: 'guest1234')
        user2 = User.new(first_name: 'Third', last_name: 'Last', email: 'email@example.com', password: 'guest1234', password_confirmation: 'guest1234')
        expect(user2).to be_invalid
      end

      it 'should be case sensitive' do
        user = User.create(first_name: 'Second', last_name: 'Last', email: 'email@example.com', password: 'guest1234', password_confirmation: 'guest1234')
        user2 = User.new(first_name: 'Third', last_name: 'Last', email: 'EMAIL@EXAMPLE.COM', password: 'guest1234', password_confirmation: 'guest1234')
        expect(user2).to be_invalid
      end
    end

    context 'must be created with first and last name fields' do
      before { user.update(password: 'test1234', password_confirmation: 'test1234') }

      it 'should be valid if given first and last name' do
        expect(user).to be_valid
      end

      it 'should be invalid if first name field is blank' do
        user.update(first_name: nil)
        expect(user).to_not be_valid
      end

      it 'should be invalid if last name field is blank' do
        user.update(last_name: nil)
        expect(user).to_not be_valid
      end
    end
  end

  describe '.authenticate_with_credentials' do
    let(:user) { User.new(first_name: 'First', last_name: 'Last', email: 'email@example.com', password: 'guest1234', password_confirmation: 'guest1234') }
    before { user.save }

    context 'given an email and password' do
      it 'should authenticate the user if valid email and password' do
        user2 = User.authenticate_with_credentials('email@example.com', 'guest1234')
        expect(user2).to eql(user)
      end

      it 'should not authenticate the user if invalid email' do
        user2 = User.authenticate_with_credentials('admin@example.com', 'guest1234')
        expect(user2).to_not eql(user)
      end

      it 'should not authenticate the user if invalid password' do
        user2 = User.authenticate_with_credentials('email@example.com', 'guest')
        expect(user2).to_not eql(user)
      end
    end

    context 'if a visitor types spaces before/after their email' do
      it 'should be authenticated successfully' do
        email = '  email@example.com '
        user2 = User.authenticate_with_credentials(email, 'guest1234')
        expect(user2).to eql(user)
      end
    end

    context 'if a visitor types the wrong case for their email' do
      it 'should be authenticated successfully' do
        email = 'EMaiL@eXampLe.cOm'
        user2 = User.authenticate_with_credentials(email, 'guest1234')
        expect(user2).to eql(user)
      end
    end
  end
end
