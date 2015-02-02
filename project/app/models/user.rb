class User < ActiveRecord::Base
	validates :username, presence: true, uniqueness: {case_sensitive: false}
	has_secure_password

	has_many :comments
	has_many :photos
	has_and_belongs_to_many :scrimages
end
