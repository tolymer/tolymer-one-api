class Mutations::DeleteTip < Mutations::BaseMutation
  argument :event_token, String, required: true

  def resolve(event_token:)
    event = Event.find_by!(token: event_token)
    tip = event.tip
    tip.destroy!
    nil
  end
end
