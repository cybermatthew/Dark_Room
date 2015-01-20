class HomeController < ApplicationController
  def index
  	if session[:id] != nil
		@currentUser = User.find(session[:id])
	end
  end
end
