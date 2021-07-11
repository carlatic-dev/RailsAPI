class Api::V1::SessionsController < ApplicationController

	def create
		@user = User.find_by(email: params[:email].downcase)
		if @user && @user.authenticate(params[:password])
			render 'create'
		else
			render json: {message: 'Invalid email/password combination'}, status: 401
		end
	end
end
