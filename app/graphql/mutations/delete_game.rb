class Mutations::DeleteGame < Mutations::BaseMutation
  argument :event_token, String, required: true
  argument :game_id, Integer, required: true

  def resolve(event_token:, game_id:)
    event = Event.find_by!(token: event_token)
    game = event.games.find(game_id)
    game.destroy!
    nil
  end
end
