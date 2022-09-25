class SendChallenegeInvitationJob < ApplicationJob
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    logger.error('User not found')
  end

  def perform(invitation_id)
    if invitation_id.to_i > 0
      invitation = ChallengeInvitation.includes(:challenge, :invited_by, :invited_to).find invitation_id
      UserMailer.challenge_invitation_email(invitation).deliver_later
    else
      UserMailer.challenge_invitation_email_only(invitation_id).deliver_later
    end
  end
end
