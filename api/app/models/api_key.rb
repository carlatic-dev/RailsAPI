# == Schema Information
#
# Table name: api_keys
#
#  id               :integer          not null      # Primary key
#  access_token     :string(255)
#  expires_at       :datetime
#  user_id          :integer                        # Foreign key to users
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class ApiKey < ActiveRecord::Base

  # Constants
  #----------------------------------------------------------------------
  DEFAULT_EXPIRE_PERIOD = 2.weeks

  # Associations
  #----------------------------------------------------------------------
  belongs_to :user

  # Callbacks
  #----------------------------------------------------------------------
  before_create :generate_access_token
  before_create :set_expiration

  # Validation methods
  #----------------------------------------------------------------------
  # Checks token expired
  def expired?
    DateTime.now.utc >= self.expires_at
  end

  # Private methods
  #----------------------------------------------------------------------
  private

    # Generates an unique access_token
    def generate_access_token
      begin
        self.access_token = User.new_token
      end while ApiKey.exists?(access_token: access_token)
    end

    # Set expiration date
    def set_expiration
      self.expires_at = DateTime.now.utc + DEFAULT_EXPIRE_PERIOD
    end

end
