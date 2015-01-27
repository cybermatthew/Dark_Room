class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find_by_id(params[:id])
		@is_user_home = params[:id].to_s == session[:id].to_s
	end

	def new
		# if session[:id] != nil
		# 	@currentUser = User.find(session[:id])
		# 	flash[:loggedin] = "Already logged in as #{@currentUser.username}"
		# else
		# 	@user = User.new
		# end
		@user = User.new
	end

	def edit
		@user = User.find_by_id(params[:id])
		@can_edit = params[:id].to_s == session[:id].to_s
	end

	def create
		@user = User.new(user_params)
		@user.points = 0;
		@user.bio = "Generic new user bio. Boo."
		if @user.save
			flash[:success] = "Successfully signed up!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def update
		@user = User.find_by_id(params[:id])
		if @user.update_attributes(user_params)
      		redirect_to @user
    	else
      		render 'edit'
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
		redirect_to :action => "index"
	end

	private
	## Strong Parameters
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end
end
