# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)`

require 'faker'

zozo = User.create!({
  email: "zozo@gmail.com",
  password: "zozozo"
})

zozo.profile.assign_attributes({
  is_mentee: true,
  name: "Zoé",
  seniority: 4,
  expertise: :fullstack,
  technologies: %i(ruby ror reactjs typescript),
  job_type: :freelance,
  expectation_attributes: {
    mentoring_skills: [:soft_skills, :career_evolution],
    technologies: [:ror],
    availability: :monthly,
    job_type: :freelance
  }
})

ProfileRepository.save!(zozo.profile)

def maybe_pick_one(values)
  ([true, false].sample && values.sample).presence
end

def maybe_pick_multiple(values, max, min = 1)
  [true, false].sample ? values.sample(rand(min..max)) : []
end

100.times do
  name = "#{Faker::Name.female_first_name} #{Faker::Name.last_name}"
  email = "#{name.downcase.gsub(" ", ".")}@#{Faker::Internet.domain_name}"
  user = User.create!(email: email, password: Faker::Internet.password)

  is_mentor = [true, false].sample
  is_mentee = [true, false].sample


  profile_attributes = {
    is_mentor: is_mentor,
    is_mentee: is_mentee,
    name: name,
    github_url: Faker::Internet.url(host: 'github.com'),
    linkedin_url: Faker::Internet.url(host: 'linkedin.com'),
    seniority: rand(0..20),
    expertise: Profile.expertise.values.sample,
    technologies: Profile.technologies.values.sample(rand(0..10)),
    industry: maybe_pick_one(Profile.industry.values),
    job_type: Profile.job_type.values.sample
  }

  if is_mentor
    profile_attributes.merge!({
      mentorship_capacity_attributes: {
        mentoring_skills: Expectation.mentoring_skills.values.sample(rand(1..7)),
        availability: Profile.availability.values.sample,
        mentee_capacity: rand(0..5)
      }
    })
  end

  if is_mentee
    profile_attributes.merge!({
      expectation_attributes: {
        mentoring_skills: Expectation.mentoring_skills.values.sample(rand(1..5)),
        availability: Profile.availability.values.sample,
        expertise: Profile.expertise.values.sample,
        technologies: maybe_pick_multiple(Profile.technologies.values, 5),
        industry: maybe_pick_one(Profile.industry.values),
        job_type: maybe_pick_one(Profile.job_type.values)
      }
    })
  end

  user.profile.assign_attributes(profile_attributes)
  ProfileRepository.save!(user.profile)
end
