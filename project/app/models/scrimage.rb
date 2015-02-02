class Scrimage < ActiveRecord::Base
	validates :name, :timed, presence: true
	# validates :name, uniqueness: {case_sensitive: false}

	has_many :photos
	has_and_belongs_to_many :users
end
