module Types
  class MutationType < Types::BaseObject
    
    field :update_profile, mutation: Mutations::UpdateProfileMutation
  end
end
