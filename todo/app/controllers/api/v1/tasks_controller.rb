class Api::V1::TasksController < ApplicationController
	before_action :restrict_access, 	only: [:index, :show, :create, :update, :destroy]		
	before_action :correct_user, 			only: [:show, :update, :destroy]	

	def index
		@tasks = @current_user.tasks.all
		render 'index'
	end
	
	def show
		render @task
	end
	
	def create
		@task = @current_user.tasks.build(task_params)
		if @task.save
			render 'create'
		else
			respond_with_error(@task)
		end
	end
	
	def update
		if @task.update_attributes(task_params)
			render json: {message: 'Task updated'}, status: 200
		else
			respond_with_error(@task)
		end
	end
	
	def destroy
		@task.destroy
		render json: {message: 'Task deleted'}, status: 200
	end
	
	private
  
    def task_params
      params.permit(:title, :completed)    
    end
		
		# Before filters
		def correct_user
			@task = Task.find(params[:id])
			render json: {message: 'You have no access to tasks of another user.'}, 
						 status: 401 unless current_user?(@task.user)
		end
end
