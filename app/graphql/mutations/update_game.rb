class Mutations::UpdateGame < Mutations::BaseMutation
  argument :event_token, String, required: true
  argument :game_id, Integer, required: true
  argument :results, [Types::GameResultInputType], required: true

  field :game, Types::GameType, null: false

  def resolve(event_token:, game_id:, results:)
    event = Event.find_by!(token: event_token)
    game = event.games.find(game_id)
    game.replace_results!(results)
    { game: game }
  end
end
