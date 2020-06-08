module Types
  class TipType < Types::Base::Object
    field :results, [Types::TipResultType], null: false
  end
end
