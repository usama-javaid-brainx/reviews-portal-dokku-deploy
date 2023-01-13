class SubCategory < ApplicationRecord

  validates :name, presence: true

  belongs_to :category
  has_many :reviews, dependent: :destroy
end
