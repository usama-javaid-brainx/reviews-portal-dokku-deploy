class AddSecondViewColunmInUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :second_view, :boolean, default: false
  end

end
