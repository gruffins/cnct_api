require 'rails_helper'

describe User do

  let (:user) { create :user }

  describe 'factories' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'validations' do
    it 'is invalid without an email' do
      expect(build(:user, email: nil)).to be_invalid
    end

    it 'is invalid withot a username' do
      expect(build(:user, username: nil)).to be_invalid
    end

    it 'is invalid without a password' do
      expect(build(:user, password: nil)).to be_invalid
    end

    it 'is invalid without a unique email' do
      expect(build(:user, email: user.email)).to be_invalid
    end

    it 'is invalid without a unique username' do
      expect(build(:user, username: user.username)).to be_invalid
    end

    it 'is invalid with a username < 3 chars' do
      expect(build(:user, username: 'a')).to be_invalid
    end

    it 'is invalid with a username that has invalid chars' do
      expect(build(:user, username: 'abc$')).to be_invalid
    end
  end

  describe '#update_user' do
    it 'can update with password' do
      user.update_attributes(password: 'password')
      expect(user.update_user(password: 'new_password', current_password: 'password')).to be_truthy
    end

    it 'can update without password' do
      expect(user.update_user(username: 'username')).to be_truthy
    end

    it 'doesnt update with bad password' do
      expect(user.update_user(password: 'abc', current_password: 'bad')).to be_falsey
    end
  end

end