class ChallengeUserSyncJob < ApplicationJob
  queue_as :default
  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    logger.error('User not found')
  end

  def perform(invitation_id)
    invitation = ChallengeInvitation.includes(:challenge, :invited_by, :invited_to).find invitation_id
    ChallangeUser.insert({challenge_id: invitation.challenge_id, shared_by: invitation.invited_by_id, accepted_by_id: invitation.invited_to_id})
  end
end