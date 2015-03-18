class PhotosController < ApplicationController

	def index
		@photos = Photo.all
	end

	def show
		@user_id = session[:id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false

		# checks if photo id is given and photo exists in db
		if !params.has_key?(:id) || !Photo.exists?(params[:id])
			flash.now[:notice] = "The selected photo does not exist on the site"
			@error = true
		else
			@photo = Photo.find(params[:id])

			scrimage = @photo.scrimage
			maxVotes = scrimage.photos.maximum("votes")

			@is_winner = false

			if @photo.scrimage.winner_id == -1 && @photo.scrimage.timed == 1 && @photo.scrimage.end_time+(5*24*60*60) <= DateTime.now
				# must declare winner for scrimage

				puts "---------------------------------------------"
				puts @photo.scrimage.end_time+5
				puts DateTime.now

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

			if(scrimage.winner_id != -1)
				@is_winner = @photo.scrimage.photos.where("votes = ?", maxVotes).include?(@photo)
			end

			@user = User.find(@photo.user_id)
			@comments = Comment.where(:photo_id => params[:id])
		end
		# @photos = Photo.all
	end

	def vote
		@photo = Photo.find(params[:photo_id])
		voted = Scrimages_User.where(user_id: current_user.id, scrimage_id: @photo.scrimage_id)
		if (!voted.any?)
			userscrimage = Scrimages_User.new(user_id: current_user.id, scrimage_id: @photo.scrimage_id)
			userscrimage.save
			@photo.votes += 1
			@photo.save
			flash[:success] = "Thanks for voting!"
		else
			flash[:error] = "You have already voted in this scrImage"
		end
		redirect_to request.referer
	end

	def create_comment
		comment = Comment.new(:photo_id => params[:photo_id], :user_id => current_user.id, :text => params[:text])
		comment.save()

		user = User.find(comment.user_id)

		render :partial => "create_comment", :locals => {:comment => comment, :user => user}
	end

	def save_edited_photo
		require "open-uri"

		if(params[:hasBeenEdited] == "true") #Called when editing the photo currently open in the API
			oldPhotoLink = params[:oldPhotoLink]
			newPhotoLink = params[:newPhotoLink]

			old_photo_name = oldPhotoLink.split("/").pop()
			new_photo_name = newPhotoLink.split("/").pop()
			new_image_from_web  = open(newPhotoLink) {|f| f.read }

			rootDir = Rails.root.join("public/images", new_photo_name)
			File.open(rootDir, 'wb') do |f| 
				f.write(new_image_from_web) 
			end			

			photo = Photo.where("filename = ?", "/images/" + old_photo_name).first
			photo.description = params[:description]
			photo.filename = "/images/" + new_photo_name
			photo.save()

			File.delete("public/images/" + old_photo_name);

			@scrimage = Scrimage.find(params[:scrimage_id])
			render :json => {:html => render_to_string({:partial => "scrimages/displayChildPhotos", :formats => [:html, :js], :locals => {:scrimage => @scrimage, :layout => false}})}  
		else #Called when saving a photo to the database for the first time
			respond_to do |format|
				format.json{
					photoName = params[:editedPhotoLink]
					image_from_web  = open(photoName) {|f| f.read }
					file_name = photoName.split("/").pop()
					rootDir = Rails.root.join("public/images", file_name)
					File.open(rootDir, 'wb') do |f| 
						f.write(image_from_web) 
					end
			
					photo = Photo.new(:filename => "/images/" + file_name, :description => params[:description], :user_id => current_user.id, :scrimage_id => params[:scrimage_id], :parent_photo_id => params[:parent_photo_id])
					photo.save()
	 				@scrimage = Scrimage.find(params[:scrimage_id])
					render :json => {:html => render_to_string({:partial => "scrimages/displayChildPhotos", :formats => [:html, :js], :locals => {:scrimage => @scrimage, :layout => false}})}  
	  			}			
	  		end
	  	end
	end

	def draw_tree
		photo = Photo.find(params["photo_id"])

		if photo.parent_photo_id != -1
			parentPhoto = Photo.find(photo.parent_photo_id)
		end

		originalPhoto = Photo.where("parent_photo_id = ? AND scrimage_id = ?", -1, photo.scrimage_id).first
		childPhotos = Photo.where("parent_photo_id = ?", photo.id)

		render :partial => "draw_tree", :locals => {:originalPhoto => originalPhoto, :curPhoto => photo, :parentPhoto => parentPhoto, :childPhotos => childPhotos}
	end

	def getPhotoForTree
		nextPhoto = Photo.find(params[:photo_id])

		render :partial => "addPhotoToTree", :locals => {:addedPhoto => nextPhoto, :original_photo_id => params[:original_photo_id]}
	end

	private
	## Strong Parameters
	def photo_params
		params.require(:photo).permit(:filename, :description, :votes, :user_id, :scrimage_id, :parent_photo_id)
	end

	def comment_params
		params.require(:comment).permit(:photo_id, :user_id, :text, :created_at)
	end
end