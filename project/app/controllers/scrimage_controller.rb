class ScrimageController < ApplicationController
	def start
		@user_id = session[:id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false
	end

	def create
		
	end
end
