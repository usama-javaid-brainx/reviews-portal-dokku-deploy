class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
end
