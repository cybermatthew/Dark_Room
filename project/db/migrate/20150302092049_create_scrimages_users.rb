class CreateScrimagesUsers < ActiveRecord::Migration
  def change
    create_join_table :scrimages, :users do |t|
  		t.index :user_id
  		t.index :scrimage_id
	end
  end
end
