# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# load users #
admin_user = User.new(:username => "admin", :password => "password", :bio => "I am the admin", :profile_image => "happy-smiling-cute-corgi-dog.jpg", :points => 100)
admin_user.save(:validate => true)

# load scrimage #
test_scrimage = Scrimage.new(:name => "Test Scrimage", :timed => 1, :start_time => DateTime.now-6, :end_time => DateTime.now-1, :description => "scrimage description", :open_for_voting => true)
test_scrimage.save(:validate => true)

# load photos #
test_photo = Photo.new(:filename => "/images/Chrysanthemum.jpg", :description => "text", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage.id)
test_photo.save(:validate => false)

child_photo = Photo.new(:filename => "/images/bees.jpg", :description => "child", :votes => 1, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => test_photo.id)
child_photo.save(:validate => false)

child_photo2 = Photo.new(:filename => "/images/goodluck.jpg", :description => "child2", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => child_photo.id)
child_photo2.save(:validate => false)

child_photo3 = Photo.new(:filename => "/images/logo_insta.png", :description => "child3", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => child_photo2.id)
child_photo3.save(:validate => false)

child_photo4 = Photo.new(:filename => "/images/Chrysanthemum.jpg", :description => "child4", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => child_photo3.id)
child_photo4.save(:validate => false)

child_photo5 = Photo.new(:filename => "/images/Chrysanthemum.jpg", :description => "child2", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage.id, :parent_photo_id => child_photo4.id)
child_photo5.save(:validate => false)

# load scrimage in edit period #
test_scrimage2 = Scrimage.new(:name => "Bees the Duck", :timed => 1, :start_time => DateTime.now-2, :end_time => DateTime.now+3, :description => "Let's edit Bees!", :open_for_voting => false)
test_scrimage2.save(:validate => true)

# load photos for scrimage in edit period #
bees = Photo.new(:filename => "/images/bees.jpg", :description => "text", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id)
bees.save(:validate => false)

bees_accessories = Photo.new(:filename => "/images/938e7e344fa64234b8890ea1daf08497.jpg", :description => "Bees with Accessories", :votes => 0, :user_id => admin_user.id, :scrimage_id => test_scrimage2.id, :parent_photo_id => bees.id)
bees_accessories.save(:validate => false)

notification = Notification.new(:user_id => admin_user.id, :message => "100 Points Awarded - You won a scrimage!")
notification.save()

# load comments #
comment = Comment.new()
comment.user_id = admin_user.id
comment.photo_id = test_photo.id
comment.text = "text"
comment.save(:validate => false)