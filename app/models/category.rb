class Category < ApplicationRecord
  has_many :review

  acts_as_list
end
