class UserController < ApplicationController
	def index
		@user = User.find_by_id(params[:id])

	end

	def new
		if session[:id] != nil
			@currentUser = User.find(session[:id])
			flash[:loggedin] = "Already logged in as #{@currentUser.username}"
		else
			@user = User.new
		end
	end

	def create
		params.permit!
		@user = User.new(params[:user])
		@user.points = 0;
		if !@user.valid?
			render :action => "new"
		else
			@user.save
			flash[:notice] = "Registration complete! Please log in."
			redirect_to :action => "login"
		end
	end

	def login
		if session[:id] != nil
			@currentUser = User.find(session[:id])
			flash[:loggedin] = "Already logged in as #{@currentUser.username}"
		else
			@user = User.new
		end
	end

	def post_login
		@user = User.find_by_username(params[:user][:username])
		if @user != nil && @user.password == params[:user][:password]
			session[:id] = @user.id
			redirect_to :controller => "home", :action => "index", :id => @user.id
		else
			flash[:notice] = "Invalid login/password combo"
			redirect_to :action => "login"
		end	
	end

	def logout
		flash[:notice] = "Successfully logged out"
		session[:id] = nil
		redirect_to :action => "login"
	end

	private
	## Strong Parameters
	def user_params
		params.require(:user).permit(:username, :password, :bio, :profile_image, :points)
	end
end
