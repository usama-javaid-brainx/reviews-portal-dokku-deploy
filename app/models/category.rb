class Category < ApplicationRecord

  acts_as_list
  has_one_attached :icon
  has_many :reviews

  end
