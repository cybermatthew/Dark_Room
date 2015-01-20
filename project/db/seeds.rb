# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# load users #
admin_user = User.new(:username => "admin", :password => "password", :bio => "I am the admin", :profile_image => "file.jpg", :points => 100)
admin_user.save(:validate => true)

# load photos #
test_photo = Photo.new(:filename => "http://photography.naturestocklibrary.com/orca-stock-photo.jpg", :description => "text", :votes => "1")
test_photo.save(:validate => false)

# load comments #
comment = Comment.new()
comment.photo_id = test_photo
comment.text = "text"
comment.save(:validate => false)