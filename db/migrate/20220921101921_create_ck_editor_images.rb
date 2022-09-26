class CreateCkEditorImages < ActiveRecord::Migration[7.0]
  def change
    create_table :ck_editor_images do |t|
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
