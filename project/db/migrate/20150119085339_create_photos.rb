class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.string :filename
    	t.string :description
    	t.integer :votes, default: 0 
    	t.integer :user_id
    	t.integer :scrimage_id
    	t.integer :parent_photo_id, default: -1
      t.timestamps null: false
    end
  end
end
