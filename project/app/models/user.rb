class User < ActiveRecord::Base
	validates_presence_of :username, :password
	validates_uniqueness_of :username, :case_sensitive => false
	validates :password, :confirmation => true

	has_many :comments
	has_many :photos
end
