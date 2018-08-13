class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(registration_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        respond_with resource, :location => after_sign_up_path_for(resource)
      end
    else
      # clean_up_passwords
       respond_with resource
      #  flash[:danger]=  respond_with resource

    end
  end
  def change_password
    author=current_author
    if author.valid_password?(author_password_params[:current_password])

      if author.change_password(author_password_params)
        sign_in(author,bypass: true)
        flash[:success] = 'Successfully changed password.'

      else
        flash[:danger] = author.display_error_messages

      end

    else
      flash[:danger] = "current password was incorrect."
    end
    redirect_to authors_account_path

  end

  private

  def registration_params
    params.require(:author).permit(:name, :email,:password, :password_confirmation)
  end
  protected

  def update_resource(resource, update_params)
    resource.update_without_password(update_params)
  end

  def update_params
    # devise_parameter_sanitizer.permit(:name, :email, :avatar,:bio)
  # params.require(:author).permit(:name, :email, :avatar,:bio)
    devise_parameter_sanitizer.for(:account_update).push(:name, :email,:country, :avatar,:bio,:profession,:f_name,:l_name,:github_id,:insta_id)

  end

end
