class SecretsController < ApplicationController
  include SecretsAccess

  before_action :verify_authenticity_token
  before_action :set_secret, only: [:show, :edit, :update, :destroy]
  before_action :verify_authorized, only: [:show, :edit, :update, :destroy]

  # GET /secrets
  # GET /secrets.json
  def index
    @secrets = User.find_by(:auth_token => authentication_params[:token]).secrets
    if @secrets.empty?
      render json: { message: 'You currently have no secrets.' }, status: 200
    else
      render json: @secrets, status: 200
    end
  end

  # GET /secrets/1
  # GET /secrets/1.json
  def show
    render json: @secret, status: 200
  end

  # POST /secrets
  # POST /secrets.json
  def create
    @secret = Secret.new(secret_params)
    @secret.user_id = User.find_by(:auth_token => authentication_params[:token]).id
    if @secret.save
      redirect_to secret_path(:id => @secret.id, :token => authentication_params['token'])
    else
      render json: { errors: 'Secret could not be created.' },  status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /secrets/1
  # PATCH/PUT /secrets/1.json
  def update
    respond_to do |format|
      if @secret.update(secret_params)
        format.json { render json: { messsage: 'Your secret has successfully been updated!', secret: @secret }, status: 200 }
      else
        format.json { render json: { errors: 'Secret could not be updated.' }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secrets/1
  # DELETE /secrets/1.json
  def destroy
    @secret.destroy
    respond_to do |format|
      format.json { render json: { message: 'Your secret has been destroyed.', secret: @secret } }
    end
  end

  private
    def verify_authenticity_token
      if !authentication_params.key?(:token) || authentication_params[:token] == "" || User.find_by(:auth_token => authentication_params[:token]).nil?
        render json: { error: 'Authentication error: No valid API token was provided in the request.' }, status: 401
      end
    end

    def verify_authorized
      unless authentication_params.key?(:token) && authentication_params.key?(:id) && authorized?(authentication_params[:id], authentication_params[:token])
        render json: { error: 'You are not authorized to access this secret.' }, status: 403
      end
    end

    def set_secret
      @secret = Secret.find(params[:id])
    end

    def authentication_params
      params.permit(:id, :token)
    end

    def secret_params
      params.permit(:id, :user_id, :secret_message)
    end
end
