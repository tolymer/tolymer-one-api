require "rails_helper"

RSpec.describe "update_game" do
  let(:event) { FactoryBot.create(:event) }
  let(:game) { FactoryBot.create(:game, event_id: event.id) }
  let(:results) { FactoryBot.create_list(:game_result, 4, game_id: game.id) }

  let(:query) {
    <<~QUERY
      mutation updateGame($event_token: String!, $game_id: Int!, $results: [GameResultInput!]!) {
        updateGame(input: { eventToken: $event_token, gameId: $game_id, results: $results }) {
          game {
            id
            results {
              participantId
              score
              rank
            }
          }
        }
      }
    QUERY
  }
  let(:variables) {
    {
      event_token: event.token,
      game_id: game.id,
      results: [
        { participantId: results[0].participant_id, score: -10 },
        { participantId: results[1].participant_id, score: 20 },
        { participantId: results[2].participant_id, score: -50 },
        { participantId: results[3].participant_id, score: 40 },
      ]
    }
  }

  specify do
    response_body = graphql_request(query, variables)
    results = game.results.map do |r|
      { participantId: r.participant_id, score: r.score, rank: r.rank }
    end
    expect(response_body[:data][:updateGame][:game][:results]).to match_array results
  end
end
