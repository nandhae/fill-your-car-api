class PasswordsController < Devise::PasswordsController
  respond_to do |format|
    format.json { render :ok }
    format.html { render :ok }
  end
  #
  # def create
  #   super
  # end
  # def edit
  #   super
  # end
  #
  # def put
  #   super
  # end

  def respond_with(resource, _opts = {})
    render json: resource
  end
end
