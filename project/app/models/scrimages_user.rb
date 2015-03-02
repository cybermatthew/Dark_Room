class Scrimages_User < ActiveRecord::Base
	belongs_to :user
  	belongs_to :scrimage

  	validates_uniqueness_of :user_id, :scope => :scrimage_id
end
