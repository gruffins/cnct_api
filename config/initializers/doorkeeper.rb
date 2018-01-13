Doorkeeper.configure do
  orm :active_record

  resource_owner_from_credentials do |routes|
    user = User.find_for_database_authentication(email: params[:email])
    if user.present? && user.valid_for_authentication? { user.valid_password? params[:password] }
      user
    end
  end

  access_token_expires_in nil
  client_credentials :from_basic
  access_token_methods :from_bearer_authorization
  grant_flows %w(client_credentials password)
end

Doorkeeper.configuration.token_grant_types << "password"