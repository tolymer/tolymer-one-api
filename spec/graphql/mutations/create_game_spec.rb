require "rails_helper"

RSpec.describe "create_game" do
  let(:event) { FactoryBot.create(:event) }
  let(:participants) { FactoryBot.create_list(:participant, 4, event_id: event.id) }

  let(:query) {
    <<~QUERY
      mutation createGame($event_token: String!, $results: [GameResultInput!]!) {
        createGame(input: { eventToken: $event_token, results: $results }) {
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
      results: [
        { participantId: participants[0].id, score: -10 },
        { participantId: participants[1].id, score: 20 },
        { participantId: participants[2].id, score: -50 },
        { participantId: participants[3].id, score: 40 },
      ]
    }
  }

  specify do
    response_body = graphql_request(query, variables)
    game = Game.find(response_body[:data][:createGame][:game][:id])
    results = game.results.map do |r|
      { participantId: r.participant_id, score: r.score, rank: r.rank }
    end
    expect(response_body[:data][:createGame][:game][:results]).to match_array results
  end
end
