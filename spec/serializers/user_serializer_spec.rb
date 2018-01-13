require 'rails_helper'

describe UserSerializer do

  let (:user) { create :user }
  let (:serializer) { UserSerializer.new(user, scope: user) }

  it 'serializes id' do
    expect(serializer.as_json[:id]).to eq(user.id)
  end

  it 'serializes username' do
    expect(serializer.as_json[:username]).to eq(user.username)
  end

  it 'serializes created_at' do
    expect(serializer.as_json[:created_at]).to eq(user.created_at)
  end

  it 'serializes updated_at' do
    expect(serializer.as_json[:updated_at]).to eq(user.updated_at)
  end

  it 'serializes email if current user' do
    expect(serializer.as_json[:email]).to eq(user.email)
  end

  it 'doesnt serializer email if not current user' do
    serializer = UserSerializer.new(user, scope: create(:user))
    expect(serializer.as_json[:email]).to be_nil
  end
  
end