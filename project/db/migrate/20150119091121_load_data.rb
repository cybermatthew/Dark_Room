class LoadData < ActiveRecord::Migration
  def change
  	test_photo = Photo.new(:filename => "http://photography.naturestocklibrary.com/orca-stock-photo.jpg", :description => "text", :votes => "1")
  	test_photo.save(:validate => false)

  	comment = Comment.new()
  	comment.photo_id = test_photo
  	comment.text = "text"
  	comment.save(:validate => false)
  end
end
