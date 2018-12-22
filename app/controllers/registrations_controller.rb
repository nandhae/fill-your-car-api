class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :authenticate_user_from_token!
  before_action :ensure_params_exist

  def create
    return user_already_exists if User.where(email: user_params[:email]).exists?

    @user = User.new(user_params)
    @auth_token = jwt_token(@user) if @user.save
    render json: { token: @auth_token }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_already_exists
    render_unauthorized errors: { unauthenticated: ['User already exists'] }
  end

  def ensure_params_exist
    return render_unauthorized errors: { bad_request: ['Incomplete credentials'] } if user_params[:email].blank? || user_params[:password].blank?
  end
end
