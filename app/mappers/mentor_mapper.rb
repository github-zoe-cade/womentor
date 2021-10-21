class MentorMapper
  class << self
    def build(user)
      results = ActiveRecord::Base.connection.execute <<-SQL
        SELECT profiles.name, mc.mentee_capacity
        FROM users
        JOIN profiles ON profiles.user_id = users.id
        JOIN mentorship_capacities mc ON mc.profile_id = profiles.id
        WHERE users.id = 101
        AND profiles.is_mentor IS TRUE
      SQL
      Mentor.new(results[0])
    end
  end
end
