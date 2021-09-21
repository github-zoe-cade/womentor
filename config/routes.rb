Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount_graphql_devise_for(User, 
    at: 'graphql_auth',
    skip: [:sign_up, :update_password, :send_password_reset, :resend_confirmation, :confirm_account, :check_password_token]
  )
  as :user do
    # Define routes for User within this block.
  end

  post "/graphql", to: "graphql#execute"

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
end
