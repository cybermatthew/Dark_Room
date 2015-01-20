class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username
    	t.string :password
    	t.string :bio
    	t.string :profile_image
    	t.integer :points
      t.timestamps null: false
    end
  end
end
