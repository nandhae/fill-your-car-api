class ApplicationController < ActionController::API
  respond_to :json
  
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
