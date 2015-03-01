class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :user_id
    	t.string :message
    	t.integer :been_viewed, default: 0
      t.timestamps null: false
    end
  end
end
