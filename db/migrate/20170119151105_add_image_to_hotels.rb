class AddImageToHotels < ActiveRecord::Migration[5.0]
  def up
    add_column :hotels, :image, :string
  end

  def down
    remove_column :hotels, :image
  end
end
