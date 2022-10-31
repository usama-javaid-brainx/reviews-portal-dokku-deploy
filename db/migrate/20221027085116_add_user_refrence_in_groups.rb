class AddUserRefrenceInGroups < ActiveRecord::Migration[7.0]
  def up
    add_reference :groups, :user, index: true
  end
  def down
    remove_reference :groups, :user, index: true
  end
end
