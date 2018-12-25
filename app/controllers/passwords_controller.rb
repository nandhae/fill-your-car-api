class PasswordsController < Devise::PasswordsController
  respond_to :json
  skip_before_action :authenticate_user!
end
