class HomeController < ApplicationController
	def index
		# gets the four most recent photos
		@new_photos = Photo.order("id DESC").limit(4)

		# gets list of scrimages (random order) open for voting
		scrimages = Scrimage.where('timed' => 1, 'open_for_voting' => true).order("RANDOM()").to_a

		# if user is logged in, eliminate scrimages he has already voted on
		if (current_user)
			scrimages.delete_if {|s|
				Scrimages_User.where(user_id: current_user.id, scrimage_id: s.id).any?
			}
		end

		# find original and child photos for the scrimage to display
		if (!scrimages.empty?) 
			@scrimage = scrimages.first
			@originalPhoto = Photo.where("parent_photo_id = ? AND scrimage_id = ?", -1, @scrimage.id).first
			@childPhotos = Photo.where("parent_photo_id != ? AND scrimage_id = ?", -1, @scrimage.id).order("votes DESC").limit(5)
		end
	end
end