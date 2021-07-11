class Task < ActiveRecord::Base
  belongs_to :user

	default_scope -> {order(:created_at => :desc)}

	validates :title, presence: true, length: { maximum: 50 }
end
