require "rails_helper"

describe "Users API", :type => :request do 
	it " creates user account and returns user\'s auth token", type: :request do
		post users_path, attributes_for(:user)
		json = JSON.parse(response.body)
    	expect(response).to have_http_status(:success)
	end

	it " does not allow user accounts with the same username to be created" do
		create(:user)
		post users_path, attributes_for(:user)
		json = JSON.parse(response.body)
    	expect(response).to have_http_status(422)
	end

	it " returns 4xx to requests by non-existing users for API keys" do
		post token_path, username: "NonExistingUser", password: "n/a"
		json = JSON.parse(response.body)
    	expect(response).to have_http_status(401)
	end

	it "returns API key for valid accounts" do
		create(:user)
		post token_path, username: "TomHanks", password: "jd*nns(49Sf0"
		json = JSON.parse(response.body)
    	expect(response).to have_http_status(:success)
    	expect(json).to have_key('api_key')
	end
end

