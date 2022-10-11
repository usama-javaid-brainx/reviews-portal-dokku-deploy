class CkEditorImage < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :file
end
