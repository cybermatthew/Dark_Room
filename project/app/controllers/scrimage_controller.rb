class ScrimageController < ApplicationController
	def index
		@user_id = session[:id]
		@loggedIn = true

		if @user_id.nil?
			@loggedIn = false
		end

		@error = false
	end
end
