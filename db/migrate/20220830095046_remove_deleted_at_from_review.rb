class RemoveDeletedAtFromReview < ActiveRecord::Migration[7.0]

  def up
    remove_column :reviews, :deleted_at, :datetime, null: true
  end
  def down
    add_column :reviews, :deleted_at, :datetime, null: true
  end
end
