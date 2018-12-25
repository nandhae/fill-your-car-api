class ApplicationController < ActionController::API
  respond_to :json
  before_action :authenticate_user!

  # def authenticate_user_from_token!
  #   if claims && (user = User.find_by(email: claims[0]['user']))
  #     @current_user = user
  #   else
  #     render_unauthorized
  #   end
  # end
  #
  # def claims
  #   (auth_header = request.headers['Authorization']) &&
  #     (token = auth_header.split(' ').last) &&
  #     ::JsonWebToken.decode(token)
  # rescue StandardError
  #   nil
  # end
  #
  # def jwt_token(user)
  #   JsonWebToken.encode('user' => user.email)
  # end
  protected

  def render_unauthorized(payload = { errors: { unauthorized: ['You are not authorized perform this action.'] } })
    render json: payload.merge(response: { code: 401 }), status: :unauthorized
  end

  def render_badrequest(payload = { errors: { unauthorized: ['invalid paramenters'] } })
    render json: payload.merge(response: { code: 400 }), status: :bad_request
  end

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end
end
