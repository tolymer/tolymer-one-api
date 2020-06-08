require "rails_helper"

RSpec.describe "delete_game" do
  let(:event) { FactoryBot.create(:event) }
  let(:game) { FactoryBot.create(:game, event_id: event.id) }
  let(:results) { FactoryBot.create_list(:game_result, 4, game_id: game.id) }

  let(:query) {
    <<~QUERY
      mutation deleteGame($event_token: String!, $game_id: Int!) {
        deleteGame(input: { eventToken: $event_token, gameId: $game_id }) {
          clientMutationId
        }
      }
    QUERY
  }
  let(:variables) {
    {
      event_token: event.token,
      game_id: game.id,
    }
  }

  specify do
    graphql_request(query, variables)
    expect(Game.count).to eq 0
    expect(GameResult.count).to eq 0
  end
end
