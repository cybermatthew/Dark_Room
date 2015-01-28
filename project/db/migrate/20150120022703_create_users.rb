class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username
    	t.string :bio
    	t.string :profile_image
    	t.integer :points
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
