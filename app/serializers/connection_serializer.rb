class ConnectionSerializer < BaseSerializer

  attributes :id

  belongs_to :other, serializer: UserSerializer

end