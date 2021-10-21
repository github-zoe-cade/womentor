class MentorSearch
  include MentorSearch::Query

  def initialize(criteria: {}, user: , mentors: UserRepository.mentors_for_search)
    @criteria = criteria
    @user = user
    @mentors = mentors
  end

  def results
    build_query
    @query.load
  end
end
