class Api::V1::UsersController < ApplicationController
	before_action :restrict_access, 	only: [:index, :update, :destroy]	
	before_action :correct_user, 			only: [:update, :destroy]	
	
	def index
		@users = User.paginate(params[:page])
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			render 'create'
		else
			respond_with_error(@user)
		end
	end
	
	def update
		if @user.update_attributes(user_params)
			render json: {message: 'Profile updated'}, status: 200
		else
			respond_with_error(@current_user)
		end
	end
	
	def destroy
		@user.destroy
		render json: {message: 'User deleted'}, status: 200
	end
	
	private
  
    def user_params
      params.permit(:email, :password, :password_confirmation,
      										:first_name, :last_name)
    end		
		
		# Before filters
		def correct_user
			@user = User.find(params[:id])
			render json: {message: 'You are not allowed to edit another user.'}, 
						 status: 401 unless current_user?(@user)
		end
end
