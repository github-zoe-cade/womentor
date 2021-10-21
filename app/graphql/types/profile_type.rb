module Types
  class ProfileType < Types::BaseObject
    field :is_mentor, Boolean, null: true
    field :is_mentee, Boolean, null: true
    field :name, String, null: true
    field :github_url, String, null: true
    field :linkedin_url, String, null: true
    field :seniority, Integer, null: true
    field :expertise, String, null: true
    field :technologies, String, null: true
    field :industry, String, null: true
    field :job_type, String, null: true
  end
end
