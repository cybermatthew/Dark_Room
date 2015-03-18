class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all
	end

	def show

		scrimages_to_update = Scrimage.where("winner_id = ? AND timed = ? AND (end_time+interval'5 days') <= ?", -1, 1, DateTime.now)

		scrimages_to_update.each do |scrimage|
			maxVotes = scrimage.photos.maximum("votes")

			winningPhotoIDs = scrimage.photos.where("votes = ?", maxVotes)

			scrimage.winner_id = winningPhotoIDs.first.id
			
			scrimage.save()

			winningPhotoIDs.each do |photoID|
				photo = Photo.find(photoID)
				notification = Notification.new(:user_id => photo.user_id, :message => "100 Points Awarded - You won the scrimage with your photo, "+photo.description+"!")

				#Ensures that all winners receive points for their winning photos
				user = User.find(photo.user_id)
				user.update(points: user.points + 100)
				
				notification.save()
			end

		end

		@user = User.find_by_id(params[:id])
		if !@user
			flash.now[:error] = "Error"
		end

		@notifications = Notification.where("user_id = ? AND been_viewed = ? AND ? = ?", @user.id, 0, @user.id, get_current_user_id())

		@userPhotos = Photo.where(user_id: params[:id])
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
			if params[:user][:profile_image]
				uploaded_io = params[:user][:profile_image]
				File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
	  			file.write(uploaded_io.read)
	  			@user.update(profile_image: params[:user][:profile_image].original_filename)
	  			end
			end
			flash[:success] = "Profile updated"
      		redirect_to @user
    	else
      		render 'edit'
    	end
	end

	def getNotifications
		user = User.find(params[:user_id])

		@notifications = Notification.where("user_id = ? AND been_viewed = ? AND ? = ?", user.id, 0, user.id, get_current_user_id())

		render :partial => "draw_notifications", :locals => {:user => user, :notifications => @notifications}
	end

	private

	# Strong Parameters, prevent mass assignment
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :bio, :profile_image)
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
