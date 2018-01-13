class UserSerializer < ActiveModel::Serializer

  attributes :id, :username, :created_at, :updated_at

  attribute :email, if: :current_user? 

  def current_user?
    object.try(:id) == scope.try(:id)
  end

end