class Mutations::CreateGame < Mutations::BaseMutation
  argument :event_token, String, required: true
  argument :results, [Types::GameResultInputType], required: true

  field :game, Types::GameType, null: false

  def resolve(event_token:, results:)
    event = Event.find_by!(token: event_token)
    game = Game.create_with_results!(event_id: event.id, results: results)
    { game: game }
  end
end
