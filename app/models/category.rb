class Category < ApplicationRecord

  has_one_attached :icon
  has_many :reviews, dependent: :destroy
  has_many :sub_categories
end