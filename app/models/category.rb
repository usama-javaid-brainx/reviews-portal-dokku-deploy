class Category < ApplicationRecord

  has_one_attached :icon
  has_many :reviews

  acts_as_list

end
