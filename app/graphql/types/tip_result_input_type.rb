module Types
  class TipResultInputType < Types::Base::InputObject
    argument :participant_id, Integer, required: true
    argument :score, Float, required: true
  end
end
