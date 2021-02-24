class User < ApplicationRecord
  has_secure_password
  has_many :bookings
  before_save :default_role
  mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  def default_role
#Bila role kosong default Guest
    unless self.role.present?
      self.role = "Guest"
    end  
  end
end
