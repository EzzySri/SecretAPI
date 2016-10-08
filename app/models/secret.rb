class Secret < ActiveRecord::Base
	belongs_to :user, required: true
	validates :secret_message, presence: true
end
