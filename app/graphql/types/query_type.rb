module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :profile, Types::ProfileType, null: false, 
      description: "Current user profile"

    def profile
      User.last.profile
    end
  end
end
