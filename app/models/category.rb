class Category < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
