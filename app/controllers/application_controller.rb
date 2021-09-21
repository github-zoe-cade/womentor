class ApplicationController < ActionController::API
    # protect_from_forgery unless: -> { request.format.json? }

    include DeviseTokenAuth::Concerns::SetUserByToken

    # before_action :authenticate_user!
    # before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.permit :sign_up, keys: :is_mentor, :is_mentee
    # end
end
