module Types
  class ParticipantType < Types::Base::Object
    field :id, Integer, null: false
    field :name, String, null: false
  end
end
