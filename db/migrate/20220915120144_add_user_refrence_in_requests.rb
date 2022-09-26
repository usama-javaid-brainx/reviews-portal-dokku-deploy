class AddUserRefrenceInRequests < ActiveRecord::Migration[7.0]
  def up
    add_reference :requests, :user, index: true
  end
  def down
    remove_reference :requests, :user, index: true
  end
end
