module Types
  class GameResultInputType < Types::Base::InputObject
    argument :participant_id, Integer, required: true
    argument :score, Float, required: true
  end
end
