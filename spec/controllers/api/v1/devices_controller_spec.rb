require 'rails_helper'

describe Api::V1::DevicesController do

  let (:user) { create :user }
  let (:device) { create :device, user: user }

  before { auth user }

  describe '#create' do
    context 'valid params' do
      it 'returns 201' do
        post :create, params: { device: { uuid: SecureRandom.uuid } }
        expect(response.status).to eq(201)
      end

      it 'creates a new device' do
        expect {
          post :create, params: { device: { uuid: SecureRandom.uuid } }
        }.to change { Device.count }.by(1)
      end
    end

    context 'invalid params' do
      it 'returns 400' do
        post :create, params: { device: { uuid: nil } }
        expect(response.status).to eq(400)
      end

      it 'doesnt create a new device' do
        expect {
          post :create, params: { device: { uuid: nil } }
        }.to change { Device.count }.by(0) 
      end
    end
  end

  describe '#destroy' do
    context 'with device' do
      it 'returns ok' do
        delete :destroy, params: { id: device.id }
        expect(response.status).to eq(200)
      end

      it 'destroys the device' do
        device
        
        expect {
          delete :destroy, params: { id: device.id }
        }.to change { Device.count }.by(-1)
      end
    end

    context 'without device' do
      it 'renders 404' do
        delete :destroy, params: { id: -1 }
        expect(response.status).to eq(404)
      end

      it 'doesnt destroy any devices' do
        expect {
          delete :destroy, params: { id: -1 }
        }.to change { Device.count }.by(0)
      end
    end
  end

end