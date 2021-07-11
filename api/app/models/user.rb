class User < ActiveRecord::Base

  # Devise methods
  #----------------------------------------------------------------------
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Associations
  #----------------------------------------------------------------------
  has_many :api_keys, dependent: :destroy

  # Authentication/Token methods
  #----------------------------------------------------------------------
  # Returns a random token.
  def self.new_token
    charset = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    (0...40).map { charset[SecureRandom.random_number(charset.size)] }.join
  end

end
