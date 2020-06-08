class Mutations::UpdateParticipants < Mutations::BaseMutation
  argument :event_token, String, required: true
  argument :renaming_participants, [Types::ParticipantRenameInputType], required: false
  argument :adding_names, [String], required: false
  argument :deleting_ids, [Integer], required: false

  field :participants, [Types::ParticipantType], null: false

  def resolve(event_token:, renaming_participants: [], adding_names: [], deleting_ids: [])
    event = Event.find_by!(token: event_token)
    participants = event.update_participants!(
      renaming_participants: renaming_participants,
      adding_names: adding_names,
      deleting_ids: deleting_ids,
    )
    { participants: participants }
  end
end
