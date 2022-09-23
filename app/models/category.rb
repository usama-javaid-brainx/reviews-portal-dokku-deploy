class Category < ApplicationRecord

  has_one_attached :icon
  has_many :reviews
  has_many :sub_categories
end