module Api
  module V1
    class ChallengesController < BaseController
      include ActiveStorage::SetCurrent
      before_action :authenticate_request
      before_action :load_challenge, only: [:invite_users]
      before_action :validate_mail_receipent, only: [:invite_users]
      
      def index
        challenges = Challenge.limit(10)
        render json: ChallengeBlueprint.render(challenges)
      end


      def create
        challenge = Challenge.new(challenge_params)
        challenge.owner_id = @current_user.id
        if challenge.save
          render json: {
            message: 'You have created a challenge. You can invite more people to accept and complete this challenge'
          }
        else
          render json: {errors: challenge.errors.full_messages}
        end
      end

      def invite_users
        Rails.logger.info("the valid")
        message = @invalid_emails.any? ? " Users with email #{@invalid_emails.join(',')} will not received invitation." : ''
        @invited_emails.each do |email|
          invited_to = User.find_by(email: email)
          if invited_to
            @challenge.challenge_invitations.new(invited_to_id: invited_to.id, invited_by_id: @current_user.id)
            Rails.logger.error("The error is #{@challenge.errors.full_messages}") unless @challenge.save
          end
        end
        render json: {message: "Users will receive invitaion email shortly.#{message}"}, status: :ok unless validate_email('email')
      end

      def invite_accepted
        invitation = @current_user.challenge_invitations.where(invitation_token: params[:invitation_token], invitation_accepted: false).first
        invitation.invitation_accepted = true
        invitation.invitation_accepted_at = DateTime.now
        invitation.invitation_token = nil
        invitation.save
      end

      private
      def challenge_params
        params[:challenge].permit(:id, :name, :description, :start_date, :end_date, :owner_id, :state, :challenge_type, :media_file)
      end

      def load_challenge
        @challenge ||= Challenge.find params[:id]
      end

      def validate_mail_receipent
        @invalid_emails = []
        @invited_emails = params[:emails].uniq
        return render json: {error: "Receipent limit too high, 5 users allowed" }, status: :unprocessable_entity if @invited_emails.size > 5
        @invited_emails.each do |email|
          unless validate_email(email)
            @invalid_emails.push(email)
            @invited_emails.delete(email)
          end
        end
      end
    end
  end
end
