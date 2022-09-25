module Api
  module V1
    class BaseController < ApplicationController
      include Validator
      before_action :authenticate_request

      private
      def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ").first
        decoded =  JsonWebToken.decode(header)
        @current_user = User.find(decoded[:user_id])
        rescue
          render json: {error: "Authorization token is missing or invalid."}, status: :unauthorized
      end

      def is_otp_verified?(user: nil)
        user = @current_user ||= user
        return render json: {error: 'Invalid username'} unless user
        return render json: {error: 'Otp code is missing'} unless params[:otp_code].present?
        user.authenticate_otp(params[:otp_code], drift: 60)
      end
    end
  end
end
