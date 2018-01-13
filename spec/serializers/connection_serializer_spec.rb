require 'rails_helper'

describe ConnectionSerializer do

  let (:connection) { create :connection }
  let (:serializer) { ConnectionSerializer.new(connection) }

  it 'serializes id' do
    expect(serializer.as_json[:id]).to eq(connection.id)
  end

  it 'serializes other' do
    expect(serializer.as_json[:other]).not_to be_nil
  end

end