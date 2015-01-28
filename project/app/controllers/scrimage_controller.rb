class ScrimageController < ApplicationController
	def new_scrimage
		@user_id = session[:id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false
	end

	def create
		
		isTimed = false
		if params[:type] == :timed
			isTimed = true
			end_time = Date.today + 5
		end

		@scrimage = Scrimage.new(:name => params[:name], :timed=> isTimed, :start_time => Date.today, :end_time => end_time, :description => params[:description])
		@scrimage.save()


		originalPhoto = Photo.new(:filename => params[:original_photo], :description => params[:description], :user_id => params[:user_id], :scrimage_id => @scrimage.id)

		originalPhoto.save()

		# render :partial => "create_comment"
	end
end
