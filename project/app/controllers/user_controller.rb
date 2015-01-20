class UserController < ApplicationController
	def index
		@users = User.all
	end

	def create
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
end
