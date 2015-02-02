class AddImageToScrimage < ActiveRecord::Migration
  def change
    add_column :scrimages, :image, :string
  end
end
