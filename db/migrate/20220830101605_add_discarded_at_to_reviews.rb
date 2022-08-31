class AddDiscardedAtToReviews < ActiveRecord::Migration[7.0]
  def up
    add_column :reviews, :discarded_at, :datetime
    add_index :reviews, :discarded_at
  end
  def down
    remove_index :reviews, column: :discarded_at
    remove_column :reviews, :discarded_at, :datetime
  end
end
