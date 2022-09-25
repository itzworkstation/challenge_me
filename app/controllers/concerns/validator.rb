require "active_support/concern"
module Validator
  extend ActiveSupport::Concern

  def validate_email(email)
    (email =~ URI::MailTo::EMAIL_REGEXP) == 0
  end
end