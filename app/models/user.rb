class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

end
