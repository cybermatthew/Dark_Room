class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.string :filename
    	t.string :description
    	t.integer :votes
    	t.integer :user_id
    	t.integer :scrimage_id
    	t.integer :parent_photo_id
      t.timestamps null: false
    end
  end
end
