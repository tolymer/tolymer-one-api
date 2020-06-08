module Types
  class EventType < Types::Base::Object
    field :token, String, null: false
    field :event_date, GraphQL::Types::ISO8601Date, null: false
    field :participants, [Types::ParticipantType], null: false
    field :games, [Types::GameType], null: false
    field :tip, Types::TipType, null: false
  end
end
