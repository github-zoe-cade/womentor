class UserRepository
  class << self
    def mentors
      User.includes(:profile).where(profiles: {is_mentor: true})
    end

    def mentors_for_search
      User.includes(profile: :mentorship_capacity).where(profiles: {is_mentor: true})
    end

    def all
      mentors
    end

    def count
      mentors.count
    end
  end
end
