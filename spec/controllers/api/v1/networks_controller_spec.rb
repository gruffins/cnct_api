require 'rails_helper'

describe Api::V1::NetworksController do

  let (:user) { create :user }
  let (:device) { create :device, user: user }
  let (:network) { create :network, device: device }

  before { auth user }

  describe '#index' do

  end

  describe '#create' do
    context 'valid params' do
      it 'returns 201' do
        post :create, params: { network: { ssid_hash: 'abc', authorization: true, max_distance: 1, device_id: device.id } }
        expect(response.status).to eq(201)
      end

      it 'creates a new network' do
        expect {
           post :create, params: { network: { ssid_hash: 'abc', authorization: true, max_distance: 1, device_id: device.id } }
         }.to change { Network.count }.by(1)
      end
    end

    context 'invalid params' do
      it 'returns 400' do
        post :create, params: { network: { ssid_hash: nil } }
        expect(response.status).to eq(400)
      end

      it 'doesnt createa new network' do
        expect {
          post :create, params: { network: { ssid_hash: nil } }
        }.to change { Network.count }.by(0)
      end
    end
  end

  describe '#update' do
    context 'with network' do
      context 'with valid params' do
        it 'returns 200' do
          put :update, params: { id: network.id, network: { authorization: false } }
          expect(response.status).to eq(200)
        end

        it 'updates the network' do
          put :update, params: { id: network.id, network: { authorization: false } }
          expect(network.authorization).to be_falsey
        end
      end

      context 'with invalid params' do
        it 'returns 400' do
          put :update, params: { id: network.id, network: { authorization: nil } }
          expect(response.status).to eq(400)
        end
      end
    end

    context 'without network' do
      it 'returns 404' do
        put :update, params: { id: -1, network: { authorization: true } }
        expect(response.status).to eq(404)
      end
    end
  end

  describe '#destroy' do
    context 'valid params' do
      it 'returns ok' do
        delete :destroy, params: { id: network.id }
        expect(response.status).to eq(200)
      end

      it 'destroys the network' do
        network

        expect {
          delete :destroy, params: { id: network.id }
        }.to change { Network.count }.by(-1)
      end
    end
  end

end