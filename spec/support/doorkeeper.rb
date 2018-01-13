def auth(user)
  app = double name: 'app'
  allow(controller).to receive(:doorkeeper_token)
    .and_return(double acceptable?: true, resource_owner_id: user.id, application: app)
end

def auth_client(app)
  token = Doorkeeper::AccessToken.create(application_id: app.id, scopes: app.scopes)
  request.headers['Authorization'] = "Bearer #{token.token}"
end