module HasExpertise
  extend ActiveSupport::Concern

  included do
    enumerize :expertise, in: %i(frontend backend fullstack mobile people_management project_management architect)
  end
end