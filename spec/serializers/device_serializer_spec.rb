require 'rails_helper'

describe DeviceSerializer do

  let (:device) { create :device }
  let (:serializer) { DeviceSerializer.new(device) }

  it 'serializes id' do
    expect(serializer.as_json[:id]).to eq(device.id)
  end

  it 'serializes uuid' do
    expect(serializer.as_json[:uuid]).to eq(device.uuid)
  end

end