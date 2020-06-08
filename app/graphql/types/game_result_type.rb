module Types
  class GameResultType < Types::Base::Object
    field :participant_id, Integer, null: false
    field :rank, Integer, null: false
    field :score, Float, null: false
  end
end
