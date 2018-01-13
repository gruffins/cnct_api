require 'rails_helper'

describe Device do

  let (:device) { create :device }

  describe 'validations' do
    it 'is invalid without a uuid' do
      expect(build(:device, uuid: nil)).to be_invalid
    end

    it 'is invalid without a unique uuid' do
      expect(build(:device, uuid: device.uuid)).to be_invalid
    end
  end

  describe 'self.find_or_create_device!' do
    context 'new device' do
      it 'creates a new device' do
        expect {
          Device.find_or_create_device!({ uuid: SecureRandom.uuid }, create(:user))
        }.to change { Device.count }.by(1)
      end
    end

    context 'previous device' do
      let!(:uuid) { device.uuid }

      it 'doesnt create a new device' do
        expect {
          Device.find_or_create_device!({ uuid: uuid }, create(:user))
        }.to change { Device.count }.by(0) 
      end

      it 'reassociates with the current user' do
        other_user = create(:user)

        device = Device.find_or_create_device!({ uuid: uuid }, other_user)
        expect(device.user).to eq(other_user)
      end
    end
  end

end