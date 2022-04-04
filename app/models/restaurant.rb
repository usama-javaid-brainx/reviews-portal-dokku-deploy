class Restaurant < ApplicationRecord

  belongs_to :user
  has_many_attached :images

  validates :name, :country, :favorite_dish, :average_score, :cuisine, :date, presence: true
end
