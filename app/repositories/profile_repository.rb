class ProfileRepository
  class << self
    def save!(profile)
      profile.save!
    end
  end
end
