Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  mount GraphqlPlayground::Rails::Engine, at: "/playground", graphql_path: "/graphql"
end
