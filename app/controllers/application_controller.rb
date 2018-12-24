class ApplicationController < ActionController::API
  respond_to :json
  before_action :authenticate_user_from_token!

  protected

  def authenticate_user_from_token!
    if claims && (user = User.find_by(email: claims[0]['user']))
      @current_user = user
    else
      render_unauthorized
    end
  end

  def claims
    (auth_header = request.headers['Authorization']) &&
      (token = auth_header.split(' ').last) &&
      ::JsonWebToken.decode(token)
  rescue StandardError
    nil
  end

  def jwt_token(user)
    JsonWebToken.encode('user' => user.email)
  end

  def render_unauthorized(payload = { errors: { unauthorized: ['You are not authorized perform this action.'] } })
    render json: payload.merge(response: { code: 401 }), status: :bad_request
  end
end
