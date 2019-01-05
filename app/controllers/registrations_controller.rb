class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # before_action :ensure_params_exist

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_already_exists
    render_badrequest errors: { unauthenticated: ['User already exists'] }
  end

  def ensure_params_exist
    render_badrequest errors: { bad_request: ['Incomplete credentials'] } if user_params[:email].blank? || user_params[:password].blank?
  end
end
