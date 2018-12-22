class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :authenticate_user_from_token!
  before_action :ensure_params_exist

  def create
    @user = User.where(email: user_params[:email]).first
    return render json: { token: @auth_token = jwt_token(@user) }, status: :ok if @user&.valid_password?(user_params[:password])

    invalid_login_attempt
  end

  def destroy
  end

  private

  def respond_to_on_destroy
    head :no_content
  end

  def invalid_login_attempt
    render_unauthorized errors: { unauthenticated: ['Invalid credentials'] }
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_params_exist
    return render_unauthorized errors: { unauthenticated: ['Incomplete credentials'] } if user_params[:email].blank? || user_params[:password].blank?
  end
end
