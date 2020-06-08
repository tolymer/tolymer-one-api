require "rails_helper"

RSpec.describe "upsert_tip" do
  let(:event) { FactoryBot.create(:event) }
  let(:participants) { FactoryBot.create_list(:participant, 4, event_id: event.id) }

  let(:query) {
    <<~QUERY
      mutation upsertTip($event_token: String!, $results: [TipResultInput!]!) {
        upsertTip(input: { eventToken: $event_token, results: $results }) {
          tip {
            results {
              participantId
              score
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
    results = event.tip.results.map do |r|
      { participantId: r.participant_id, score: r.score }
    end
    expect(response_body[:data][:upsertTip][:tip][:results]).to match_array results
  end
end
