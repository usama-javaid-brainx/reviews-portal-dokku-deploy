class AddImageUploadTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image_upload_token, :string
  end
end
