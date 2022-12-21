class AddUsernameToUserRemoveFirstAndLastnameFromUser < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :username, :string, default: "", null: false
    # assigning username to all users by combining first and last name
    User.all.each do |user|
      user.update(username: "#{user.first_name.downcase}#{user.last_name.downcase}")
    end

    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end

  def down
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    remove_column :users, :username, :string
  end
end
