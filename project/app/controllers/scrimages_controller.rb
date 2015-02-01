class ScrimagesController < ApplicationController
	def show
		@scrimage = Scrimage.find(params[:id])
		@remainingSeconds = (@scrimage.end_time.to_time - DateTime.now.to_time).to_i

		@original_photo = Photo.where("scrimage_id = ? AND parent_photo_id = ?", @scrimage.id, -1).first
		@photos = Photo.where("scrimage_id = ? AND parent_photo_id != ?", @scrimage.id, -1)
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
		end_time = DateTime.now

		if params[:type] == "timed"
			isTimed = 1
			end_time = DateTime.now + 5
		end

		scrimage = Scrimage.new(:name => params[:name], :timed=> isTimed, :start_time => Date.today, :end_time => end_time, :description => params[:description])
		scrimage.save()


		originalPhoto = Photo.new(:filename => params[:original_photo], :description => params[:description], :user_id => params[:user_id], :scrimage_id => scrimage.id)

		originalPhoto.save()

		redirect_to action: "index", id: scrimage.id
	end
end
