require 'rails_helper'

describe MentorSearch do
  describe '::results' do
    subject { mentor_search.results }
    let(:mentor_search) { described_class.new(criteria: criteria, user: user) }
    let(:criteria) { {} }
    let(:user) { create(:user, profile: { seniority: 0 }) }

    let(:mentor) { create(:mentor, profile: { mentorship_capacity: { mentee_capacity: 5 } }) }
    let(:mentor_no_capacity) { create(:mentor, profile: { mentorship_capacity: { mentee_capacity: 0 } }) }

    let!(:mentors) { [mentor, mentor_no_capacity] }

    it 'excludes mentors with no mentee_capacity' do
      expect(subject).to match_array([mentor])
    end

    describe 'seniority' do
      let(:user) { create(:user, profile: {seniority: 2}) }
      let(:young_mentor) { create(:mentor, profile: { seniority: 3 })}
      let(:mentor1) { create(:mentor, profile: { seniority: 4 })}
      let(:mentor2) { create(:mentor, profile: { seniority: 5 })}
      let(:mentor3) { create(:mentor, profile: { seniority: 15 })}
      let!(:mentors) { [young_mentor, mentor1, mentor2, mentor3]}

      it 'excludes mentors who have less than 2 years of xp more than the user' do
        expect(subject).to match_array([mentor1, mentor2, mentor3])
      end

      it 'computes the seniority_score' do
        expect(subject.map { |x| [x.seniority, x.seniority_score] }).to match_array(
            [[4, 90], [5, 100], [15, 0]]
          )
      end
    end

    context 'when the user is also a mentor' do
      let(:user) { create(:mentor, profile: {seniority: 0}) }

      it 'excludes the user from the mentors' do
        expect(subject).to match_array([mentor])
      end
    end

    context 'when the availability criterion is provided' do
      let(:monthly_mentor) { create(:mentor, profile: { mentorship_capacity: { availability: :monthly } }) }
      let(:weekly_mentor) { create(:mentor, profile: { mentorship_capacity: { availability: :weekly } }) }
      let(:mentors) { [monthly_mentor, weekly_mentor] }

      context 'and it is weekly' do
        let(:criteria) { { availability: :weekly } }

        it 'applies the weekly score' do
          expect(subject.map { |x| [x.availability, x.availability_score] }).to match_array(
            [['monthly', 0], ['weekly', 100]]
          )
        end
      end

      context 'and it is monthly' do
        let(:criteria) { { availability: :monthly } }

        it 'applies the monthly score' do
          expect(subject.map { |x| [x.availability, x.availability_score] }).to match_array(
            [['monthly', 100], ['weekly', 50]]
          )
        end
      end
    end

    ## Single value criteria tests

    context 'when the job type criterion is provided' do
      let(:mentor1) { create(:mentor, profile: { job_type: :freelance }) }
      let(:mentor2) { create(:mentor, profile: { job_type: :freelance }) }
      let(:mentor3) { create(:mentor, profile: { job_type: :startup }) }
      let(:mentors) { [mentor1, mentor2, mentor3] }
      let(:criteria) { { job_type: :freelance } }

      it 'applies the job type score' do
        expect(subject.map { |x| [x.job_type, x.job_type_score] }).to match_array(
          [['freelance', 33], ['freelance', 33], ['startup', 0]]
        )
      end
    end

    context 'when the expertise criterion is provided' do
      let(:mentor1) { create(:mentor, profile: { expertise: :frontend }) }
      let(:mentor2) { create(:mentor, profile: { expertise: :frontend }) }
      let(:mentor3) { create(:mentor, profile: { expertise: :backend }) }
      let(:mentors) { [mentor1, mentor2, mentor3] }
      let(:criteria) { { expertise: :frontend } }

      it 'applies the expertise score' do
        expect(subject.map { |x| [x.expertise, x.expertise_score] }).to match_array(
          [['frontend', 33], ['frontend', 33], ['backend', 0]]
        )
      end
    end

    context 'when the industry criterion is provided' do
      let(:mentor1) { create(:mentor, profile: { industry: :blockchain }) }
      let(:mentor2) { create(:mentor, profile: { industry: :blockchain }) }
      let(:mentor3) { create(:mentor, profile: { industry: :fintech }) }
      let(:mentors) { [mentor1, mentor2, mentor3] }
      let(:criteria) { { industry: :blockchain } }

      it 'applies the industry score' do
        expect(subject.map { |x| [x.industry, x.industry_score] }).to match_array(
          [['blockchain', 33], ['blockchain', 33], ['fintech', 0]]
        )
      end
    end

    ## Multiple value criteria tests

    context 'when the technologies criterion is provided' do
      context 'when it has only one value' do
        let(:mentor1) { create(:mentor, profile: { technologies: [:ruby] }) }
        let(:mentor2) { create(:mentor, profile: { technologies: %i[ruby reactjs] }) }
        let(:mentor3) { create(:mentor, profile: { technologies: [:reactjs] }) }
        let(:mentors) { [mentor1, mentor2, mentor3] }
        let(:criteria) { { technologies: [:ruby] } }

        it 'applies the technologies score' do
          expect(subject.map { |x| [x.technologies, x.technologies_score] }).to match_array(
            [[['ruby'], 33], [%w[ruby reactjs], 17], [['reactjs'], 0]]
          )
        end
      end

      context 'when it has several value' do
        let(:mentor1) { create(:mentor, profile: { technologies: %i[ruby reactjs] }) }
        let(:mentor2) { create(:mentor, profile: { technologies: %i[ruby reactjs python] }) }
        let(:mentor3) { create(:mentor, profile: { technologies: [:ruby] }) }
        let(:mentor4) { create(:mentor, profile: { technologies: [:reactjs] }) }
        let(:mentor5) { create(:mentor, profile: { technologies: [:python] }) }
        let(:mentors) { [mentor1, mentor2, mentor3, mentor4, mentor5] }
        let(:criteria) { { technologies: %i[ruby reactjs] } }

        it 'applies the technologies score with rarity constraint and exact match bonus' do
          expect(subject.map { |x| [x.technologies, x.technologies_score] }).to match_array(
            [
              [%w[ruby reactjs], 80], # (40 + 40) / (2/2)
              [%w[ruby reactjs python], 53], # (40 + 40) / (2/3)
              [['reactjs'], 40],
              [['ruby'], 40], # 40 / (1/2)
              [['python'], 0]
            ]
          )
        end
      end
    end

    context 'when the mentoring skills criterion is provided' do
      let(:mentor1) { create(:mentor, profile: {mentorship_capacity: { mentoring_skills: %i[tech_skills career_evolution] } }) }
      let(:mentor2) { create(:mentor, profile: {mentorship_capacity: { mentoring_skills: %i[tech_skills career_evolution soft_skills] } }) }
      let(:mentor3) { create(:mentor, profile: {mentorship_capacity: { mentoring_skills: [:tech_skills] } }) }
      let(:mentor4) { create(:mentor, profile: {mentorship_capacity: { mentoring_skills: [:career_evolution] } }) }
      let(:mentor5) { create(:mentor, profile: {mentorship_capacity: { mentoring_skills: [:soft_skills] } }) }
      let(:mentors) { [mentor1, mentor2, mentor3, mentor4, mentor5] }
      let(:criteria) { { mentoring_skills: %i[tech_skills career_evolution] } }

      it 'applies the mentoring skills score with rarity constraint and exact match bonus' do
        expect(subject.map { |x| [x.mentoring_skills, x.mentoring_skills_score] }).to match_array(
          [
            [%w[tech_skills career_evolution], 80], # (40 + 40) / (2/2)
            [%w[tech_skills career_evolution soft_skills], 53], # (40 + 40) / (2/3)
            [['career_evolution'], 40],
            [['tech_skills'], 40], # 40 / (1/2)
            [['soft_skills'], 0]
          ]
        )
      end
    end
  end
end
