module HasIndustry
  extend ActiveSupport::Concern
  included do

    enumerize :industry, in: %i(
      blockchain
      cybersecurity
      ecommerce
      fintech
      gaming
      iot
      media
      legaltech
      luxury
      retail
      social
    )
  end
end
