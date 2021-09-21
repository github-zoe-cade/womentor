class ApplicationController < ActionController::API
  # protect_from_forgery unless: -> { request.format.json? }
  include GraphqlDevise::Concerns::SetUserByToken
  
end
