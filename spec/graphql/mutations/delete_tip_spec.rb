require "rails_helper"

RSpec.describe "delete_tip" do
  let(:event) { FactoryBot.create(:event) }
  let!(:tip) { FactoryBot.create(:tip, event_id: event.id) }
  let!(:results) { FactoryBot.create_list(:tip_result, 4, tip_id: tip.id) }

  let(:query) {
    <<~QUERY
      mutation deleteTip($event_token: String!) {
        deleteTip(input: { eventToken: $event_token }) {
          clientMutationId
        }
      }
    QUERY
  }
  let(:variables) {
    {
      event_token: event.token,
    }
  }

  specify do
    graphql_request(query, variables)
    expect(Tip.count).to eq 0
    expect(TipResult.count).to eq 0
  end
end
