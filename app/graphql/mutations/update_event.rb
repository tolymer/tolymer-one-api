class Mutations::UpdateEvent < Mutations::BaseMutation
  argument :event_token, String, required: true
  argument :event_date, GraphQL::Types::ISO8601Date, required: true

  field :event, Types::EventType, null: false

  def resolve(event_token:, event_date:)
    event = Event.find_by!(token: event_token)
    event.update!(event_date: event_date)
    { event: event }
  end
end
