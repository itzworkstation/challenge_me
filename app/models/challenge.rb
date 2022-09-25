class Challenge < ApplicationRecord
  has_one_attached :media_file
  enum :state, [ :draft, :published, :closed ]
  enum :challenge_type, [ :text, :video, :image]
  validates :name, :description, :start_date, :end_date, presence: true
  belongs_to :owner, class_name: 'User'
  has_many :challenge_invitations

  def media_url
    Rails.application.routes.url_helpers.url_for(media_file) if media_file.attached?
  end
end
