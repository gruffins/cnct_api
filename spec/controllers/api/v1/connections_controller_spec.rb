require 'rails_helper'

describe Api::V1::ConnectionsController do

  let (:user) { create :user }
  let (:other) { create :user }
  let (:connection) { create :connection, user: user, other: other }

  before { auth user } 

  describe '#index' do

  end

  describe '#create' do
    context 'with valid params' do
      it 'returns created' do
        post :create, params: { connection: { other_id: other.id } }
        expect(response.status).to eq(201)
      end

      it 'creates 2 conections' do
        expect {
          post :create, params: { connection: { other_id: other.id } }
        }.to change { Connection.count }.by(2)
      end
    end

    context 'with invalid params' do
      it 'returns 400' do
        post :create, params: { connection: { other_id: nil } }
        expect(response.status).to eq(400)
      end
    end
  end

  describe '#destroy' do
    context 'with valid params' do
      it 'returns 200' do
        delete :destroy, params: { id: connection.id }
        expect(response.status).to eq(200)
      end

      it 'destroys' do
        connection

        expect {
          delete :destroy, params: { id: connection.id }
        }.to change { Connection.count }.by(-2)
      end
    end

    context 'with invalid params' do
      it 'returns 404' do
        delete :destroy, params: { id: -1 }
        expect(response.status).to eq(404)
      end
    end
  end

  describe '#approve' do
    before do
      auth(other)

      connection.update_attributes(status: :pending_sent)
      connection.reciprical.update_attributes(status: :pending_received)
    end

    context 'with valid params' do
      it 'returns 200' do
        post :approve, params: { connection_id: connection.reciprical.id }
        expect(response.status).to eq(200)
      end

      it 'updates the statuses' do
        post :approve, params: { connection_id: connection.reciprical.id }

        connection.reload
        connection.reciprical.reload

        expect(connection.status).to eq('approved')
        expect(connection.reciprical.status).to eq('approved')
      end
    end

    context 'with invalid params' do
      it 'returns 404' do
        post :approve, params: { connection_id: -1 }
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#reject" do
    before do
      auth(other)

      connection.update_attributes(status: :pending_sent)
      connection.reciprical.update_attributes(status: :pending_received)
    end

    context 'with valid params' do
      it 'returns 200' do
        post :reject, params: { connection_id: connection.reciprical.id }
        expect(response.status).to eq(200)
      end

      it 'updates the statuses' do
        post :reject, params: { connection_id: connection.reciprical.id }

        connection.reload
        connection.reciprical.reload

        expect(connection.status).to eq('rejected_sent')
        expect(connection.reciprical.status).to eq('rejected_received')
      end
    end

    context 'with invalid params' do
      it 'returns 404' do
        post :reject, params: { connection_id: -1 }
        expect(response.status).to eq(404)
      end
    end
  end

end