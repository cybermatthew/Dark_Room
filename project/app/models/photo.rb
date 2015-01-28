class Photo < ActiveRecord::Base
	validates :filename, :user_id, :scrimage_id, :presence => true
	
	belongs_to :user
	has_many :comments
	belongs_to :scrimage
end
