class User < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_one_time_password length: 4
  has_and_belongs_to_many :roles
  validates :name, :mobile_number, presence: true
  validates :mobile_number, length: {is: 10, message: "must be 10 digit"}, uniqueness: {message: "already exist" }
  validates :email, allow_nil: true, uniqueness: {message: "already exist" }
  after_commit :send_otp, on: :create
  has_many :created_challenges, foreign_key: 'owner_id', class_name: 'Challenge'
  has_many :challenge_invitations, foreign_key: 'invited_to_id'

  def admin?
    roles.include?('admin')
  end

  private
  def send_otp
    SendOtpJob.perform_later(self.id)
  end
end
