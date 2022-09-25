class SendOtpJob < ApplicationJob
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    logger.error('User not found')
  end

  def perform(user_id)
    user = User.find user_id
    otp_code = user.otp_code(time: Time.now + 7200)
    UserMailer.otp_verification_email(user, otp_code).deliver_later
  end
end
