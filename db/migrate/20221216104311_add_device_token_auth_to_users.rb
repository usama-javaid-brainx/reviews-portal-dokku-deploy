class AddDeviceTokenAuthToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :device_token, :string, null: false, default: ""
    add_column :users, :app_platform, :integer, null: false, default: 0
    add_column :users, :app_version, :string, null: false, default: ""
    add_column :users, :status, :integer, null: false, default: 0
    add_column :users, :provider, :string, null: false, default: "email"
    add_column :users, :uid, :string, null: false, default: ""
    add_column :users, :allow_password_change, :boolean, default: false
    add_column :users, :confirmation_token, :string
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :tokens, :text

    add_index :users, :confirmation_token, unique: true
  end

end

