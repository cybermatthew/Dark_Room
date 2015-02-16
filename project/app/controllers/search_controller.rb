class SearchController < ApplicationController
	def index
		@all_original_photos = Photo.where("parent_photo_id = ?", -1).order("updated_at desc")
	end
end
