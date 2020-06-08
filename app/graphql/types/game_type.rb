module Types
  class GameType < Types::Base::Object
    field :id, Integer, null: false
    field :results, [Types::GameResultType], null: false
  end
end
