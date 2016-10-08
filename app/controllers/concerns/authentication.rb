require 'securerandom'

module Authentication
	def auth_token(user_id)
		@user = User.find(user_id)
		if @user.auth_token.nil?
 			@user.auth_token = SecureRandom.hex(15)
 			@user.save
		end
		@user.auth_token
	end
end