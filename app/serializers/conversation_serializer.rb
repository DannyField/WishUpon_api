class ConversationSerializer < ActiveModel::Serializer
  # Serializers will specifiy which data from the models will
  # get shared when broadcasting. Here when broadcasting
  # only the id, and title will be sent.
  attributes :id, :title
  has_many :messages
end

# I wonder now if I could have passed through a user_id
# attributes to include a user. Next feature release.
