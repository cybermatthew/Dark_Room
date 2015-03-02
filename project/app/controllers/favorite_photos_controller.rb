class FavoritePhotosController < ApplicationController
before_action :set_project
  
  def create
    if Favorite.create(favorited: @photo, user: current_user)
      redirect_to @photo
    else
      redirect_to @photo, alert: 'Oops. Something went wrong.'
    end
  end
  
  def destroy
    Favorite.where(favorited_id: @photo.id, user_id: current_user.id).first.destroy
    redirect_to @photo
  end
  
  private
  
  def set_project
    @photo = Photo.find(params[:photo_id] || params[:id])
  end
end