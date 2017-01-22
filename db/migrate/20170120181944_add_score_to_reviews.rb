class AddScoreToReviews < ActiveRecord::Migration[5.0]
  def up
    add_column :reviews, :score, :integer, default: 0
  end

  def down
    remove_column :reviews, :score
  end
end
