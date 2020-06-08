require "rails_helper"

RSpec.describe "update_event" do
  let(:event) { FactoryBot.create(:event, event_date: '2020-01-01') }
  let(:query) {
    <<~QUERY
      mutation updateEvent($event_token: String!, $event_date: String!) {
        updateEvent(input: { eventToken: $event_token, eventDate: $event_date }) {
          event {
            token
          }
        }
      }
    QUERY
  }
  let(:variables) {
    {
      event_token: event.token,
      event_date: "2020-01-02",
    }
  }

  specify do
    response_body = graphql_request(query, variables)
    expect(event.reload.event_date).to eq Date.new(2020, 1, 2)
  end
end
