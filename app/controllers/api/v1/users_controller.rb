module Api
  module V1
    class UsersController < BaseController
      include ActiveStorage::SetCurrent
      skip_before_action :authenticate_request, only: [:signup, :verify_otp, :index]
      def index
        @users = User.all #.joins(:avatar_attachment)
        render json: UserBlueprint.render(@users)
        # render json: @users.map { |user| 
        #    user.as_json(only: ['name', 'mobile_number', 'sdsds']).merge(
        #    avatar_path: url_for(user.avatar.variant(resize_to_limit: [100, 100])) )}  
      end

      def signup
        user = User.new(signup_params)
        if user.save
          render json: {message: 'You will recieve an OTP shortly on your email or mobile no'}, status: :created
        else
          render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
      end

      def verify_otp
        user = User.where(mobile_number: params[:username]).or(User.where(email: params[:username])).first
        if user && is_otp_verified?(user: user)
          if user.update_attribute('is_verified', true)
            token = JsonWebToken.encode(user_id: user.id)
            time = Time.now + 24.hours.to_i
            response = UserBlueprint.render(user, access_token: token)
            render json: response
          end
        else
          msg = user.present? ? "Invalid verification code" : "Invalid user"
          render json: {error: msg}, status: :unprocessable_entity
        end
      end

      private
      def signup_params
        params.require(:user).permit(:name, :email, :mobile_number, :avatar)
      end
    end
  end
end
