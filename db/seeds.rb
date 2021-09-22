# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

zozo = User.create!({
  email: "zozo@gmail.com",
  password: "zozozo"
})

zozo.profile.update!({
  is_mentee: true,
  name: "Zoé",
  seniority: 4,
  expertise: :fullstack,
  technologies: ['ruby', 'ror', 'reactjs', 'typescript'],
  job_type: :freelance,
  expectation_attributes: {
    mentoring_skills: [:soft_skills],
    technologies: ['ror'],
    availability: :monthly,
    job_type: :freelance
  }
})

huey = User.create!({email: "huey@gmail.com", password: "hueyhuey"})
huey.profile.update!({
  is_mentee: true,
  name: "Huey",
  seniority: 4,
  expertise: :frontend,
  technologies: ['reactjs', 'typescript'],
  job_type: :freelance,
  mentorship_capacity_attributes: {
    mentoring_skills: [:soft_skills],
    availability: :monthly,
    mentee_capacity: 3
  }
})

dewey = User.create!({email: "dewey@gmail.com", password: "deweydewey"})
dewey.profile.update!({
  is_mentee: true,
  name: "Dewey",
  seniority: 10,
  expertise: :fullstack,
  technologies: ['reactjs', 'typescript'],
  job_type: :freelance,
  mentorship_capacity_attributes: {
    mentoring_skills: [:soft_skills],
    availability: :weekly,
    mentee_capacity: 1
  }
})

louie = User.create!({email: "louie@gmail.com", password: "louielouie"})
louie.profile.update!({
  is_mentee: true,
  name: "Louie",
  seniority: 6,
  expertise: :backend,
  technologies: ['reactjs', 'ror'],
  job_type: :startup,
  mentorship_capacity_attributes: {
    mentoring_skills: [:technical_skills],
    availability: :weekly,
    mentee_capacity: 3
  }
})
 
scrooge = User.create!({email: "scrooge@gmail.com", password: "scroogescrooge"})
scrooge.profile.update!({
  is_mentee: true,
  name: "Scrooge",
  seniority: 10,
  expertise: :fullstack,
  technologies: ['ruby', 'ror'],
  job_type: :freelance,
  mentorship_capacity_attributes: {
    mentoring_skills: [:soft_skills],
    availability: :monthly,
    mentee_capacity: 0
  }
})