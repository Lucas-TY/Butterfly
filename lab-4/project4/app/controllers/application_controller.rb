class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery prepend: true
    # Adds parameters to the devise routes to allow for initialization of additional attributes
    protected def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
        
    end

end
