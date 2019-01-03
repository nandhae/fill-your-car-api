class PasswordsController < Devise::PasswordsController
  respond_to :json

  def edit
    super
  end

  def put
    super
  end
end
