class AddDiscardedAtToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at
  end

  def down
    remove_index :users, column: :discarded_at
    remove_column :users, :discarded_at, :datetime
  end
end
