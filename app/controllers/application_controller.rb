class ApplicationController < ActionController::Base
    before_action :authenticate

   rescue_from JWT::VerificationError, with: :invalid_token
   rescue_from JWT::DecodeError, with: :decode_error

   private

   def authenticate
     auth_header = request.headers['Authorization']
     token = auth_header.split(" ").last if auth_header
     decoded_token = JsonWebToken.decode(token)

     User.find(decoded_token[:user_id])
   end

   def invalid_token
     render json: { message: 'Invalid token' }
   end

   def decode_error
     render json: { message: 'Token decoding error' }
   end
end
