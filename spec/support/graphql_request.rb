module GraphqlRequest
  def graphql_request(query, variables = {})
    post "/graphql", params: { query: query, variables: variables }.to_json, headers: { "Content-Type" => "application/json" }
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:errors]).to eq nil
    body
  end
end
