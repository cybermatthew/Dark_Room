class Photo < ActiveRecord::Base
	validates :filename, :presence => true
	
	belongs_to :user
	has_many :comments
	belongs_to :scrimage
end
