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
			@user = User.find(@photo.user_id)
			@comments = Comment.where(:photo_id => params[:id])
		end
		# @photos = Photo.all
	end

	def create_comment
		@comment = Comment.new(:photo_id => params[:photo_id], :user_id => params[:user_id], :text => params[:text])
		@comment.save()

		render :partial => "create_comment"
	end

	def save_edited_photo
		require "open-uri"
		respond_to do |format|
			format.json{
				photoName = params[:editedPhotoLink]
				image_from_web  = open(photoName) {|f| f.read }
				file_name = photoName.split("/").pop()
				rootDir = Rails.root.join("public/images", file_name)
				File.open(rootDir, 'wb') do |f| 
					f.write(image_from_web) 
				end
				render :json => {:file_name => photoName} #Sends the photo link back as a response.
			}
  		end
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
