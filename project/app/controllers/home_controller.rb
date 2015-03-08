class HomeController < ApplicationController
	def index
		@new_photos = Photo.order("id DESC").limit(4)
		@scrimage = Scrimage.where("timed = ? AND open_for_voting = ?", 1, true).order("RANDOM()").first
		@noscrimage = false;
		if (@scrimage)
			@originalPhoto = Photo.where("parent_photo_id = ? AND scrimage_id = ?", -1, @scrimage.id).first
			@childPhotos = Photo.where("parent_photo_id != ? AND scrimage_id = ?", -1, @scrimage.id).order("votes DESC").limit(5)
		else
			@noscrimage = true;
		end
	end
end
