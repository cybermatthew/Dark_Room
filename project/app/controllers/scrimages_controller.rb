class ScrimagesController < ApplicationController
	def show
		@scrimage = Scrimage.find(params[:id])
	end

	def new_scrimage
		@user_id = session[:id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false
	end

	def create

		isTimed = 0
		end_time = Date.today

		if params[:type] == "timed"
			isTimed = 1
			end_time = Date.today + 5
		end

		scrimage = Scrimage.new(:name => params[:name], :timed=> isTimed, :start_time => Date.today, :end_time => end_time, :description => params[:description])
		scrimage.save()


		originalPhoto = Photo.new(:filename => params[:original_photo], :description => params[:description], :user_id => params[:user_id], :scrimage_id => scrimage.id)

		originalPhoto.save()

		redirect_to action: "index", id: scrimage.id
	end
end
