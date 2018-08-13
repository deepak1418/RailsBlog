class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password,
                                                               :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name,:bio,:country, :email, :password,:profession,:f_name,:l_name,:github_id,:insta_id,
                                                                      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar) }
  end

  layout 'author'

end
