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
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  private
  def self.authenticate_with_credentials(email, password)
    normalize_email = email.strip.downcase
    user = User.find_by(email: normalize_email)

    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
