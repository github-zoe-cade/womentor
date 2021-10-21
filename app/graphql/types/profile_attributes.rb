module Types
  class ProfileAttributes < Types::BaseInputObject
    description 'Attributes for updating the user own profile'

    argument :name, String, required: true
    argument :github_url, String, required: false
    argument :linkedin_url, String, required: false
    argument :seniority, Int, required: true
    argument :expertise, String, required: true
    argument :technologies, [String], required: false
    argument :industry, String, required: false
    argument :job_type, String, required: true
  end
end