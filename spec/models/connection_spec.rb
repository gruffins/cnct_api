require 'rails_helper'

describe Connection do

  let (:user) { create :user }
  let (:other) { create :user }

  describe 'validations' do
    it 'is invalid with duplicate' do
      create :connection, user: user, other: other
      expect(build(:connection, user: user, other: other)).to be_invalid
    end
  end

  describe '#accept!' do
    before do
      Connection.create!(user: user, other: other)
    end

    it 'updates status to approved' do
      connection = Connection.find_by(user: other, other: user)
      connection.accept!

      expect(connection.status).to eq('approved')
    end

    it 'updates reciprical to approved' do
      connection = Connection.find_by(user: other, other: user)
      connection.accept!

      reciprical = Connection.find_by(user: user, other: other)
      expect(reciprical.status).to eq('approved')
    end
  end

  describe '#reject' do
    before do
      Connection.create!(user: user, other: other)
    end

    it 'updates status to rejected_received' do
      connection = Connection.find_by(user: other, other: user)
      connection.reject!

      expect(connection.status).to eq('rejected_received')
    end

    it 'updates reciprical status to rejected_sent' do
      connection = Connection.find_by(user: other, other: user)
      connection.reject!

      reciprical = Connection.find_by(user: user, other: other)
      expect(reciprical.status).to eq('rejected_sent')
    end
  end

  describe 'after_commit callbacks' do
    describe '#create_reciprical' do
      it 'creates the reciprical' do
        create :connection, user: user, other: other

        expect(Connection.find_by(user: other, other: user)).to be_present
      end
    end

    describe '#destroy_reciprical' do
      it 'destroys the reciprial' do
        connection = create :connection, user: user, other: other

        connection.destroy

        expect(Connection.find_by(user: connection.other, other: connection.user)).to be_nil
      end
    end
  end
  
end