class MentorSearch

  def initialize(criteria: {}, user: nil, mentors: [])
    @criteria = criteria
    @user = user
    @mentors = mentors
  end

  def results
    @query = Mentor.all
    @query.where(availability: :weekly) if criteria[:availability] === :weekly
    @query
  end

  # MentorSearch.new(
    #criteria: MentorSearch::Criteria.new(user.expectations), 
    #user: user, 
    #mentors: MentorSearch::MentorRepository.all
  #).results
end