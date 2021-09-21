module HasJobType
  extend ActiveSupport::Concern
  included do
    
    enumerize :job_type, in: %i(freelance startup enterprise consulting)
  end
end