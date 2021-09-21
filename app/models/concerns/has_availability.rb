module HasAvailability
  extend ActiveSupport::Concern

  included do
    enumerize :availability, in: %i(weekly monthly)
  end
end