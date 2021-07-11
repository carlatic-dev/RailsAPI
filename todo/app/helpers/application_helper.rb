module ApplicationHelper
	
	# Returns errors of object in json format.
	def respond_with_error(object)
		render json: {messages: object.errors.full_messages.join("\r\n")}, status: 401
	end
	
	# Returns true if the given user is the current user.
	def current_user?(user)
		user == @current_user
	end
end