class ScrimagesController < ApplicationController
	before_action :logged_in_user, only: [:new_scrimage, :update]

	def show
		@scrimage = Scrimage.find(params[:id])
		@remainingSeconds = remaining_time(@scrimage)
		@votingRemainingSeconds = voting_time(@scrimage)
		if (@votingRemainingSeconds <= 0)
			@scrimage.update_attribute(:open_for_voting, false);
		end

		@original_photo = Photo.where("scrimage_id = ? AND parent_photo_id = ?", @scrimage.id, -1).first

		@numWinnerVotes = -1
		@winningPhotos = []

		if (@scrimage.winner_id != -1)
			@numWinnerVotes = Photo.find(@scrimage.winner_id).votes
			@winningPhotos =  Photo.where("scrimage_id = ? AND votes == ?", @scrimage.id, @numWinnerVotes)
		end

		# @photos = Photo.where("scrimage_id = ? AND parent_photo_id != ?", @scrimage.id, -1)
	end

	def new_scrimage
	end

	def create
		if !params[:original_photo].nil?
			isTimed = 0
			start_time = DateTime.now
			end_time = start_time

			if params[:type] == "timed"
				isTimed = 1
				end_time = end_time + 5
			end

			scrimage = Scrimage.new(:name => params[:name], :timed=> isTimed, :start_time => start_time, :end_time => end_time, :description => params[:description], :open_for_voting => 0)
			scrimage.save()

			if scrimage.id
				uploaded_io = params[:original_photo]
				File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
		    		file.write(uploaded_io.read)
		  		end

				originalPhoto = Photo.new(:filename => "/images/" + params[:original_photo].original_filename, :description => params[:description], :user_id => current_user.id, :scrimage_id => scrimage.id)

				originalPhoto.save()

				if originalPhoto.id
					redirect_to :action => "show", :id => scrimage.id
				else
					delete scrimage

					flash[:error] = "Error saving photo"
					redirect_to :action => "new_scrimage"
				end

			else
				flash[:error] = "A scrimage must have a title"
				redirect_to :action => "new_scrimage"
			end
		else
			flash[:error] = "You must select a photo for the scrimage"
			redirect_to :action => "new_scrimage"
		end
	end

	def uploadEditedImage

		uploaded_io = params[:editedPhoto]
		File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
    			file.write(uploaded_io.read)
  		end

	  	newPhoto = Photo.new(:filename => "/images/" + uploaded_io.original_filename, :description => params[:editedPhotoText], :user_id => current_user.id, :scrimage_id => params[:scrimage_id], :parent_photo_id => params[:parent_photo_id])
	  	newPhoto.save()

	  	@scrimage = Scrimage.find(params[:scrimage_id])

		render :partial => "displayChildPhotos", :locals => {:scrimage => scrimage}
	end

	def render_children
		@scrimage = Scrimage.find(params[:scrimage_id])
		if params[:voting]
			@scrimage.update_attribute(:open_for_voting, true);
		else
			@scrimage.update_attribute(:open_for_voting, false);
		end
		render :json => {:html => render_to_string({:partial => "scrimages/displayChildPhotos", :formats => [:html, :js], :locals => {:scrimage => @scrimage, :layout => false}})}
	end

	# returns json array with ids of the winning photos
	def set_winner
		respond_to do |format|
			format.json{
				scrimage = Scrimage.find(params[:scrimage_id])

				maxVotes = scrimage.photos.maximum("votes")

				winningPhotoIDs = scrimage.photos.where("votes = ?", maxVotes)

				scrimage.winner_id = winningPhotoIDs.first.id
				
				scrimage.save()

				winningPhotoIDs.each do |photoID|
					photo = Photo.find(photoID)
					notification = Notification.new(:user_id => photo.user_id, :message => "100 Points Awarded - You won the scrimage with your photo, "+photo.description+"!")
					notification.save()
				end

				render :json => {:winningPhotoID => winningPhotoIDs}  
  			}			
  		end
	end

	def add_share
		respond_to do |format|
			format.json{
				@scrimage = Scrimage.find(params[:scrimage_id])
				render :json => {:html => render_to_string({:partial => "displayChildPhotos", :formats => [:html, :js], :locals => {:scrimage => @scrimage}, :layout => false})}  
  			}			
  		end
	end

	# Before filters

    def logged_in_user # Confirms user is logged in
      unless logged_in?
        flash[:error] = "Please log in"
        redirect_to login_url
      end
    end
end