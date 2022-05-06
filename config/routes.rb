Rails.application.routes.draw do
  root to: ->(env) { [404, {}, []] }
  get "/ping", to: ->(env) { [200, {}, ["pong"]] }
  post "/graphql", to: "graphql#execute"
  mount GraphqlPlayground::Rails::Engine, at: "/playground", graphql_path: "/graphql"
end
