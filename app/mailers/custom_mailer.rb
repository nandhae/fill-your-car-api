class CustomMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def password_reset_instructions(record, token, opts = {})
    opts[:from] = 'my_custom_from@domain.com'
    opts[:reply_to] = 'my_custom_from@domain.com'
    super
  end
end
