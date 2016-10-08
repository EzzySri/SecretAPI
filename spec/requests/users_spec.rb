require "rails_helper"

describe "Users API", :type => :request do 
	it "Creates user account and returns user\'s auth token", type: :request do
		@user = FactoryGirl.create(:user)
		post 'users', @user #{ :username => "Robert Downey Jr", :password => "jd*nns(49Sf0" }
		json = JSON.parse(response.body)
    	expect(response).to be_success
	end
end