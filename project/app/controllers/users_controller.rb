class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all
	end

	def show
		@user = User.find_by_id(params[:id])
		if !@user
			flash.now[:error] = "Error"
		end 
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find_by_id(params[:id])
	end

	def create
		@user = User.new(user_params)
		uploaded_io = params[:user][:profile_image]
		File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
	  			file.write(uploaded_io.read)
	  	end
	  	@user.profile_image = params[:user][:profile_image].original_filename
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
			flash[:success] = "Profile updated"
      		redirect_to @user
    	else
      		render 'edit'
    	end
	end

	private

	# Strong Parameters, prevent mass assignment
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :bio)
	end

	# Before filters

    def logged_in_user # Confirms user is logged in
      unless logged_in?
        flash[:error] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
    	@user = User.find(params[:id])
      	unless current_user?(@user)
      		flash[:error] = "You do not have permission to edit this user's profile"
      		redirect_to(root_url) 
      	end
    end
end
