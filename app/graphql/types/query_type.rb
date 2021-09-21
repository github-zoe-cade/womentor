module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :user, Types::UserType, null: false
    field :profile, Types::ProfileType, null: false, 
      description: "Current user profile"

    def profile
      current_user.profile
    end

    def user
      current_user
    end
  end
end
