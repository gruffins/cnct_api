require 'rails_helper'

describe Api::V1::UsersController do

  let (:user) { create :user }
  let (:app) { Doorkeeper::Application.create(name: 'app') }

  describe '#create' do
    before { auth_client app }

    context 'valid params' do
      let (:new_user) { build(:user) }

      it 'returns 201' do
        post :create, params: { user: { username: new_user.username, email: new_user.email, password: "password" } }
        expect(response.status).to eq(201)
      end

      it 'creates a user' do
        expect {
          post :create, params: { user: { username: new_user.username, email: new_user.email, password: "password" } }
        }.to change { User.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns 400' do
        post :create, params: { user: { username: '' } }
        expect(response.status).to eq(400)
      end

      it 'doesnt create a new user' do
        expect {
          post :create, params: { user: { username: '' } }
        }.to change { User.count }.by(0)
      end
    end
  end

  describe '#show' do
    before { auth user }

    context 'with valid user' do
      it 'returns 200' do
        get :show, params: { id: user.id }
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid user' do
      it 'returns 404' do
        get :show, params: { id: -1 }
        expect(response.status).to eq(404)
      end
    end
  end

  describe '#me' do
    before { auth user }
    
    it 'returns 200' do
      get :me
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    before { auth user }

    context 'with valid params' do
      it 'returns ok' do
        put :update, params: { id: user.id, user: { username: 'abcd' } }
        expect(response.status).to eq(200)
      end

      it 'updates the user' do
        put :update, params: { id: user.id, user: { username: 'abcd' } }

        user.reload
        
        expect(user.username).to eq('abcd')
      end
    end

    context 'with invalid params' do
      it 'returns bad_request' do
        put :update, params: { id: user.id, user: { username: '' } }
        expect(response.status).to eq(400)
      end

      it 'doesnt update the user' do
        put :update, params: { id: user.id, user: { username: '' } }
        expect(user.username).not_to be_blank
      end
    end

    context 'another user' do
      it 'returns bad_request' do
        put :update, params: { id: -1, user: { username: 'abcd' } }
        expect(response.status).to eq(400)
      end
    end
  end

end