require 'httparty'

# PlanetScaleがしばらくwriteがないと寝るので定期的にアクセスして起こすためのバッチ。ついでに死活監視も兼ねる。
class HealthCheckBatch
  ENDPOINT = 'https://tolymer-one-api-vhzj342dlq-an.a.run.app/graphql'

  def self.run
    self.new.run
  end

  def run
    token = create_event
    raise 'Failed request' unless token
    puts "created: #{token}"
  end

  def create_event
    query = <<~GRAPHQL
      mutation createEvent($eventDate: ISO8601Date!, $participants: [String!]!) {
        createEvent(input: {eventDate: $eventDate, participants: $participants}) {
          event {
            token
          }
        }
      }
    GRAPHQL

    response = request(
      operation_name: 'createEvent',
      query: query,
      variables: {
        eventDate: "2022-01-01",
        participants: ["test-1", "test-2", "test-3", "test-4"]
      }
    )

    response['createEvent']['event']['token']
  end

  def request(operation_name:, query:, variables: {})
    headers = {
      'Content-Type' => 'application/json'
    }
    body = {
      operationName: operation_name,
      query: query,
      variables: variables,
    }.to_json

    response = HTTParty.post(ENDPOINT, { body:, headers: })

    response['data']
  end
end
