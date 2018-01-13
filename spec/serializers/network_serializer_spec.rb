require 'rails_helper'

describe NetworkSerializer do

  let (:network) { create :network }
  let (:serializer) { NetworkSerializer.new(network) }

  it 'serializes id' do
    expect(serializer.as_json[:id]).to eq(network.id)
  end

  it 'serializes ssid_hash' do
    expect(serializer.as_json[:ssid_hash]).to eq(network.ssid_hash)
  end

  it 'serializes authorization' do
    expect(serializer.as_json[:authorization]).to eq(network.authorization)
  end

  it 'serializes max_distance' do
    expect(serializer.as_json[:max_distance]).to eq(network.max_distance)
  end
  
end