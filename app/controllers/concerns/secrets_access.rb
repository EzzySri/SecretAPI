module SecretsAccess
	def authorized?(secret_id, auth_token)
		@user = User.find_by(:auth_token => auth_token)
		return secretOwner?(secret_id, @user)
	end

	def secretOwner?(secret_id, user)
		return Secret.find_by(:id => secret_id, :user_id => user.id).present?
	end
end