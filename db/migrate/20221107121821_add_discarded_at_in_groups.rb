class AddDiscardedAtInGroups < ActiveRecord::Migration[7.0]
  def up
    add_column :groups, :discarded_at, :datetime
    add_index :groups, :discarded_at
  end

  def down
    remove_index :groups, column: :discarded_at
    remove_column :groups, :discarded_at, :datetime
  end
end
