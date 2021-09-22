require "rails_helper"

describe Types::QueryType do
  subject { WomentorSchema.execute(query, context: {current_resource: user}).as_json }
  let(:user) { create(:user)}

  describe "field#profile" do
    let!(:profile) { user.profile }
    let(:query) do
      %(query {
        profile {
          userId
        }
      })
    end

    it "returns the current user profile fields" do
      expect(subject.dig("data", "profile", "userId")).to eq(user.id)
    end
  end
end