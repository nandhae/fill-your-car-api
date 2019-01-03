class SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :ensure_params_exist

  # def create
  #   @user = User.where(email: user_params[:email]).first
  #   if @user&.valid_password?(user_params[:password])
  #     response.headers['token'] = jwt_token(@user)
  #     return render json: { message: 'Login successful' }, status: :ok
  #   end
  #   invalid_login_attempt
  # end
  def show
    user_signed_in?
  end
  # def destroy
  # end

  private

  def respond_with(resource, _opts = {})
    render json: resource, status: :ok
  end

  def respond_to_on_destroy
    head :ok
  end

  def invalid_login_attempt
    render_badrequest errors: { unauthenticated: ['Invalid credentials'] }
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_params_exist
    return render_badrequest errors: { unauthenticated: ['Incomplete credentials'] } if user_params[:email].blank? || user_params[:password].blank?
  end
end
