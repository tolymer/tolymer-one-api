Rails.application.routes.draw do
  root to: ->(env) { [404, {}, []] }
  post "/graphql", to: "graphql#execute"
  mount GraphqlPlayground::Rails::Engine, at: "/playground", graphql_path: "/graphql"
end
