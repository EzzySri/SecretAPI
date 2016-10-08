class UsersController < ApplicationController
  include Authentication
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json { render json: { message: @user.username + "'s account successfully created.",  api_key: auth_token(@user.id) }, status: 200 }
      else
        format.json { render json: { errors: "Either the existing username is already taken or the provided registration information is missing a username or password value." }, status: :unprocessable_entity }
      end
    end
  end

  def authentication_token
  	@user = User.find_by(:username => user_params[:username]);
  		if @user.present? && @user.authenticate(user_params[:password])
  			render json: { message: "User " + @user.username + " 's authentication token retrieved successfully", api_key: auth_token(@user.id) }, status: 200 
  		else
  			render json: { errors: 'No user account with that information matches our records.' }, status: 401 
  		end
  end

  private 
  	def user_params
  		params.permit(:username, :password, :password_confirmation, :token)
  	end
end
