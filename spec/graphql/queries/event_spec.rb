require "rails_helper"

RSpec.describe "event" do
  let(:event) { FactoryBot.create(:event, event_date: event_date) }
  let(:event_date) { "2020-01-02" }
  let!(:p1) { FactoryBot.create(:participant, event_id: event.id) }
  let!(:p2) { FactoryBot.create(:participant, event_id: event.id) }
  let!(:p3) { FactoryBot.create(:participant, event_id: event.id) }
  let!(:p4) { FactoryBot.create(:participant, event_id: event.id) }
  let!(:game) do
    Game.create_with_results!(event_id: event.id, results: [
      { participant_id: p1.id, score: -10 },
      { participant_id: p2.id, score: 20 },
      { participant_id: p3.id, score: -50 },
      { participant_id: p4.id, score: 40 },
    ])
  end
  let!(:tip) do
    Tip.create_or_replace!(event_id: event.id, results: [
      { participant_id: p1.id, score: 10 },
      { participant_id: p2.id, score: -20 },
      { participant_id: p3.id, score: 50 },
      { participant_id: p4.id, score: -40 },
    ])
  end

  let(:query) {
    <<~QUERY
      query getEvent($token: String!) {
        event(token: $token) {
          token
          eventDate
          participants {
            id
            name
          }
          games {
            id
            results {
              participantId
              score
              rank
            }
          }
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

  specify do
    response_body = graphql_request(query, { token: event.token })
    res_event = response_body[:data][:event]

    expect(res_event[:token]).to eq event.token
    expect(res_event[:eventDate]).to eq event_date
    expect(res_event[:participants]).to match_array [
      { id: p1.id, name: p1.name },
      { id: p2.id, name: p2.name },
      { id: p3.id, name: p3.name },
      { id: p4.id, name: p4.name },
    ]
    expect(res_event[:games][0][:id]).to eq game.id
    expect(res_event[:games][0][:results]).to match_array [
      { participantId: p1.id, score: -10, rank: 3 },
      { participantId: p2.id, score: 20, rank: 2 },
      { participantId: p3.id, score: -50, rank: 4 },
      { participantId: p4.id, score: 40, rank: 1 },
    ]
    expect(res_event[:tip][:results]).to match_array [
      { participantId: p1.id, score: 10 },
      { participantId: p2.id, score: -20 },
      { participantId: p3.id, score: 50 },
      { participantId: p4.id, score: -40 },
    ]
  end
end
