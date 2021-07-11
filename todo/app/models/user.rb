class User < ActiveRecord::Base
	
	has_many :tasks,   dependent: :destroy
	has_one  :api_key, dependent: :destroy

	before_save   :downcase_email
	after_create  :create_api_key

	has_secure_password

  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :first_name,  presence: true, length: { maximum: 30 }
	validates :last_name,  	presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
	                      format: { with: VALID_EMAIL_REGEX },
	                      uniqueness: true

	# Returns the hash digest of the given string
	def User.digest(string)
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	private
		# Converts email to all lower-case
		def downcase_email
			self.email = email.downcase
		end

		def create_api_key
	    	self.api_key = ApiKey.create(user: self)
    end
end
