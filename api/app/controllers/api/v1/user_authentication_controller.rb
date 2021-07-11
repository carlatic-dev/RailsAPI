class Api::V1::UserAuthenticationController < ApplicationController
  
  before_action :authenticate_source_domain!

  def create
    if params[:email].present?
      user = User.where(email: params[:email]).first
      if user.present?
        if user.valid_password?(params[:password])
          @api_key = user.api_keys.create
          render 'create'
        else
          render json: {message: "Incorrect password"}, status: 401
        end
      else
        render json: {message: "Invalid email"}, status: 403
      end
    else
      render json: {message: "Email can't be blank."}, status: 401
    end
  end
  
end
