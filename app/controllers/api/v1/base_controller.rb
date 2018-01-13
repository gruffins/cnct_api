class Api::V1::BaseController < ActionController::Base

  before_action :doorkeeper_authorize!

  protected

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token.present? && doorkeeper_token.resource_owner_id.present?
  end

end