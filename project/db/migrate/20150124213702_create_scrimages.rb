class CreateScrimages < ActiveRecord::Migration
  def change
    create_table :scrimages do |t|
      t.string :name
      t.integer :timed
    	t.datetime :start_time
    	t.datetime :end_time, default: false
      t.boolean :open_for_voting, default: false
    	t.string :description
    	t.integer :winner_id, default: -1
      t.timestamps null: false
    end
  end
end