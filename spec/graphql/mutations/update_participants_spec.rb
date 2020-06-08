require "rails_helper"

RSpec.describe "update_participants" do
  let(:event) { FactoryBot.create(:event) }
  let(:participants) { FactoryBot.create_list(:participant, 4, event_id: event.id) }

  let(:query) {
    <<~QUERY
      mutation updateParticipants(
        $event_token: String!
        $renaming_participants: [ParticipantRenameInput!]
        $adding_names: [String!]
        $deleting_ids: [Int!]
      ) {
        updateParticipants(input: {
          eventToken: $event_token
          renamingParticipants: $renaming_participants
          addingNames: $adding_names
          deletingIds: $deleting_ids
        }) {
          participants {
            id
            name
          }
        }
      }
    QUERY
  }
  let(:variables) {
    {
      event_token: event.token,
      renaming_participants: [{ id: participants[0].id, name: 'renamed' }],
      adding_names: ['added'],
      deleting_ids: [participants[2].id]
    }
  }

  specify do
    graphql_request(query, variables)
    expect(event.reload.participants.pluck(:name)).to match_array [
      participants[1].name,
      participants[2].name,
      'added',
      'renamed',
    ]
  end
end
