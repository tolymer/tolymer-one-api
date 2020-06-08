class Mutations::CreateEvent < Mutations::BaseMutation
  argument :event_date, GraphQL::Types::ISO8601Date, required: true
  argument :participants, [String], required: true

  field :event, Types::EventType, null: false

  def resolve(event_date:, participants:)
    event = Event.create_with_participants!(event_date: event_date, participants: participants)
    { event: event }
  end
end
