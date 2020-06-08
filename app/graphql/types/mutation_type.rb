module Types
  class MutationType < Types::Base::Object
    field :create_event, mutation: Mutations::CreateEvent
    field :update_event, mutation: Mutations::UpdateEvent

    field :update_participants, mutation: Mutations::UpdateParticipants

    field :create_game, mutation: Mutations::CreateGame
    field :update_game, mutation: Mutations::UpdateGame
    field :delete_game, mutation: Mutations::DeleteGame

    field :upsert_tip, mutation: Mutations::UpsertTip
    field :delete_tip, mutation: Mutations::DeleteTip
  end
end
