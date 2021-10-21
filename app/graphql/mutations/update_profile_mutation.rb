module Mutations
  class UpdateProfileMutation < Mutations::BaseMutation
    argument :attributes, Types::ProfileAttributes, required: true

    field :profile, Types::ProfileType, null: true

    def resolve(attributes: )
      profile.assign_attributes(attributes.to_h)

      if profile.save
        {profile: profile}
      else
        {errors: profile.errors}
      end
    end

    private

    def profile
      @profile ||= current_user.profile
    end
  end
end
