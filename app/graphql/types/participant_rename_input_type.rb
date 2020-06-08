module Types
  class ParticipantRenameInputType < Types::Base::InputObject
    argument :id, Integer, required: true
    argument :name, String, required: true
  end
end
