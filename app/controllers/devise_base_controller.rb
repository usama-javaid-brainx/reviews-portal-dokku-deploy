class DeviseBaseController < ActionController::Base
  layout 'devise_base'
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number])
  end

end
