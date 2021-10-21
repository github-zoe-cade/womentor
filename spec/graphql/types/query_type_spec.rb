require "rails_helper"

describe Types::QueryType do
  subject { WomentorSchema.execute("query #{query}", context: {current_resource: user}).as_json }
  let(:user) { create(:user, profile: {name: "Kashmir"})}

  describe "field#user" do
    let(:query) { "{ user { email } }" }

    it "returns the current user fields" do
      expect(subject.dig("data", "user", "email")).to eq("kashmir@gmail.com")
    end
  end

  describe "field#profile" do
    let!(:profile) { user.profile }
    let(:query) { "{ profile { name } }" }

    it "returns the current user profile fields" do
      expect(subject.dig("data", "profile", "name")).to eq("Kashmir")
    end
  end
end
