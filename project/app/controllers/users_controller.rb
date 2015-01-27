class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find_by_id(params[:id])
		@is_user_home = params[:id].to_s == session[:id].to_s
	end

	def new
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
			log_in @user
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

	private
	## Strong Parameters
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end
end
