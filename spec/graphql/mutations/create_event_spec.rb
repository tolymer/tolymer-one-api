require "rails_helper"

RSpec.describe "create_event" do
  let(:query) {
    <<~QUERY
      mutation createEvent($event_date: ISO8601Date!, $participants: [String!]!) {
        createEvent(input: { eventDate: $event_date, participants: $participants }) {
          event {
            token
          }
        }
      }
    QUERY
  }
  let(:variables) {
    {
      event_date: "2020-01-02",
      participants: ["a", "b", "c", "d"],
    }
  }

  specify do
    response_body = graphql_request(query, variables)
    token = response_body[:data][:createEvent][:event][:token]
    event = Event.find_by!(token: token)
    expect(event.event_date).to eq Date.new(2020, 1, 2)
    expect(event.participants.map(&:name)).to match_array ["a", "b", "c", "d"]
  end
end
