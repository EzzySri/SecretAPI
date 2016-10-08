require "rails_helper"

describe "Secrets API", :type => :request do 
	before (:each) do
		@user = create(:user)
		@userB = create(:user, username: 'RobertDowneyJr', password: '83hsd9#nj', auth_token: '64e51985972026962e9321043215df')
		@secret = create(:secret)
	end

	it " only allows valid users with API keys to create a secret" do
		post secrets_path, secret_message: "New secret message.", token: 's8fsddd9djhl33'
		expect(response).to have_http_status(401)
	end

	it " allows secret creator to view secret", type: :request do
		get secret_path(@secret.id), token: @user.auth_token
		json = JSON.parse(response.body)
    	expect(response).to have_http_status(:success)
    	expect(json["secret_message"]).to eq("This is a top secret message.")
	end

	it " allows secret creator to delete secret", type: :request do
    	delete secret_path(@secret), token: @user.auth_token
    	expect(Secret.all.length).to be(0)
    	expect(response).to have_http_status(:success)
	end

	it " allows secret creator to update secret", type: :request do
		patch secret_path(@secret.id), secret_message: "Updated secret message!", token: @user.auth_token
		json = JSON.parse(response.body)
		secret = Secret.find(@secret.id)
    	expect(secret.secret_message).to eq("Updated secret message!")
	end

	it " does not allow other users to view secret", type: :request do
		get secret_path(@secret.id), token: @userB.auth_token
		json = JSON.parse(response.body)
    	expect(response).to have_http_status(403)
	end

	it " does not allow other users to delete secret", type: :request do
    	delete secret_path(@secret), token: @userB.auth_token
    	expect(Secret.all.length).to be(1)
    	expect(response).to have_http_status(403)
	end

	it " does not allow other users to update secret", type: :request do
		patch secret_path(@secret.id), secret_message: "Updated secret message!", token: @userB.auth_token
		json = JSON.parse(response.body)
		secret = Secret.find(@secret.id)
    	expect(secret.secret_message).to eq("This is a top secret message.")
    	expect(response).to have_http_status(403)
	end

	it " provides a list of a user's secrets" do
		create(:secret, secret_message: "Tom Hank's second secret message", user_id: 1)
		get secrets_path, token: @user.auth_token
		json = JSON.parse(response.body)
		expect(json.length).to eq(Secret.where(:user_id => @user.id).all.length)
	end
end

