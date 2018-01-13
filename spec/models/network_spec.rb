require 'rails_helper'

describe Network do

  let (:network) { create :network }

  describe 'validations' do
    it 'is invalid without a ssid_hash' do
      expect(build(:network, ssid_hash: nil)).to be_invalid
    end

    it 'is invalid without authorization' do
      expect(build(:network, authorization: nil)).to be_invalid
    end

    it 'is invalid with max_distance 0' do
      expect(build(:network, max_distance: 0)).to be_invalid
    end
  end

end