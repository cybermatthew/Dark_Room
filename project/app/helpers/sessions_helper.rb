module SessionsHelper
	def log_in(user)
    session[:user_id] = user.id
	end

	def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
	end

	# is 'user' the current user?
	def current_user?(user)
  	user == current_user
	end

	def get_current_user_id
		return session[:user_id]
	end

 	def logged_in?
   		!current_user.nil? # calls above method
 	end

 	def log_out
 		session.delete(:user_id)
    	@current_user = nil
 	end
end
