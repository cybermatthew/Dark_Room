class SearchesController < ApplicationController
	def show
		@all_original_photos = Photo.where("parent_photo_id = ?", -1).order("updated_at desc")
		# @foundScrimages = []
	end

	def searchData
		searchString = params[:search_string]

		scrimage_photos = nil
		individual_photos = nil

		if searchString == ""
			# if there is an empty search string, we just find all scrimages
			scrimage_photos = Photo.where("parent_photo_id = ?", -1).order("updated_at desc")

			render :partial => "fill_data", :locals => {:show_all_scrimages => 1, :found_scrimages_by_photos => scrimage_photos, :found_photos => individual_photos}
		else
			scrimage_photos = Photo.joins(:scrimage).where("parent_photo_id = ? AND (scrimages.name like ? OR scrimages.description like ?)", -1, "%"+searchString+"%", "%"+searchString+"%").order("updated_at desc")

			individual_photos = Photo.where("description like ?", "%"+searchString+"%").order("updated_at desc")

			render :partial => "fill_data", :locals => {:show_all_scrimages => 0, :found_scrimages_by_photos => scrimage_photos, :found_photos => individual_photos}
		end
	end
end
