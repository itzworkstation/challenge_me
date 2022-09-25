class UserMailer < ApplicationMailer
  def otp_verification_email(user, otp_code)
    @user = user
    @otp = otp_code
    mail(to: @user.email, subject: 'Your signup/signin otp')
  end

  def challenge_invitation_email(invitation)
    @invitation = invitation
    @url = "http://google.com"
    mail(to: @invitation.invited_to.email, subject: "You have invited in #{invitation.challenge.name}")
  end
  
end