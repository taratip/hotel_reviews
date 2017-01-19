class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.text :description
      t.integer :number_rooms

      t.timestamps null: false
    end

    add_index :hotels, :name, unique: true
  end
end
