class User < ActiveRecord::Base
	validates :username, :password, :presence => true

	has_many :comments
	has_many :photos
end
