module Types
  class TipResultType < Types::Base::Object
    field :participant_id, Integer, null: false
    field :score, Float, null: false
  end
end
