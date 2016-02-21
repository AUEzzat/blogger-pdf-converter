class User < ActiveRecord::Base
  before_save { email.downcase! }
  has_many :posts, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :password_confirmation_equal_password

	def password_confirmation_equal_password
		if password_confirmation!=password
			errors.add(:password_confirmation,"and password aren't the same")
		end
	end

end
