# lib/json_web_token.rb

class JsonWebToken
  class << self
    def encode(payload, exp = 4.weeks.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV['DEVISE_JWT_SECRET_KEY'])
    end

    def decode(token)
      body = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'])[0]
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
