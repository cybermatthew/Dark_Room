class CreateScrimages < ActiveRecord::Migration
  def change
    create_table :scrimages do |t|
    	t.datetime :start_time
    	t.datetime :end_time, default: false
    	t.integer :original_photo_id
    	t.string :description
    	t.integer :winner_id
      t.timestamps null: false
    end
  end
end
