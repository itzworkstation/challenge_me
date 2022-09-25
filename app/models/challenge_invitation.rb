class ChallengeInvitation < ApplicationRecord
  has_secure_token :invitation_token, length: 36
  belongs_to :challenge
  belongs_to :invited_by, class_name: 'User'
  belongs_to :invited_to, class_name: 'User'
  after_commit :send_invitation, on: :create
  after_commit :move_record_to_challenge_users, on: :update

  private
  def send_invitation
    SendChallenegeInvitationJob.perform_later(self.id)
  end

  def move_record_to_challenge_users
    if self.invitation_accepted? && self.invitation_accepted_previously_changed?
      ChallangeUserSyncJob.perform_later(self.id)
    end
  end
end
