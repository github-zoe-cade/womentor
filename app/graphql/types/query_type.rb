module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :user, Types::UserType, null: false
    field :profile, Types::ProfileType, null: false, 
      description: "Current user profile"

    def profile
      User.last.profile
    end

    def user
      User.last
    end
  end
end
