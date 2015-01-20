class PhotoController < ApplicationController
	def index
		@user_id = session[:user_id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false

		# checks if photo id is given and photo exists in db
		if !params.has_key?(:id) || !Photo.exists?(params[:id])
			flash[:notice] = "The selected photo does not exist on the site"
			@error = true
		else
			@photo = Photo.find(params[:id])
			@comments = Comment.where(:photo_id => params[:id])
		end
		# @photos = Photo.all
	end


	def create_comment
		@comment = Comment.new(:photo_id => params[:photo_id], :user_id => params[:user_id], :text => params[:text])
		@comment.save()

		render :partial => "create_comment"
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
