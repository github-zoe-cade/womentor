Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount_devise_token_auth_for 'User', at: 'auth'
  post "/graphql", to: "graphql#execute"

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
end
