class HomeController < ApplicationController
	def index
		@new_photos = Photo.order("id DESC").limit(4)
	end

end
