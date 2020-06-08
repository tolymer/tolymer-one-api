module Types
  class QueryType < Types::Base::Object
    field :event, resolver: Queries::Event
  end
end
