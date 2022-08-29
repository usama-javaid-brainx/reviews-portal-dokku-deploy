class AddDeletedAtToReview < ActiveRecord::Migration[7.0]
  def up
    add_column :reviews, :deleted_at, :datetime, null: true
  end
  def down
    remove_column :reviews, :deleted_at, :datetime, null: true
  end
end
