class Mutations::UpsertTip < Mutations::BaseMutation
  argument :event_token, String, required: true
  argument :results, [Types::TipResultInputType], required: true

  field :tip, Types::TipType, null: false

  def resolve(event_token:, results:)
    event = Event.find_by!(token: event_token)
    tip = Tip.create_or_replace!(event_id: event.id, results: results)
    { tip: tip }
  end
end
