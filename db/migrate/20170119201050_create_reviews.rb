class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false
      t.belongs_to :hotel, null: false
      t.integer :rating,  null: false
      t.text :body

      t.timestamps null: false
    end
  end
end
