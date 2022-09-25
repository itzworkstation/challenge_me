class ChallengeUser < ApplicationRecord
  has_one_attached :media_file
  enum :state, [:draft, :submitted]
  belongs_to :challenge
  belongs_to :shared_by, class_name: 'User'
  belongs_to :accepted_by, class_name: 'User'

  def self.insert_record(attr)
    Rails.logger.info("The challange attributes are #{attr}")
    challenge_user = new(attr)
    if challenge_user.valid?
      challenge_user.save
    else
      Rails.logger.error("Something went wrong with data: #{challenge_user.errors.full_messages}")
    end
  end
end
