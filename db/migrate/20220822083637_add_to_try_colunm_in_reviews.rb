class AddToTryColunmInReviews < ActiveRecord::Migration[7.0]
  def up
    add_column :reviews, :to_try, :boolean, default: false
  end
  def down
    remove_column :reviews, :to_try, :boolean, default: false
  end
end
