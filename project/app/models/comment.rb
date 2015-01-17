class Comment < ActiveRecord::Base
	attr_accessible :photo_id, :user_id, :text, :created_at
	validates :text, :presence => true
	
	belongs_to :photo
	belongs_to :user
end
