class Scrimage < ActiveRecord::Base
	validates :name, :timed, presence: true, uniqueness: {case_sensitive: false}

	has_many :photos
	has_many :users
end
