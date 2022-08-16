# == Schema Information
#
# Table name: meals
#
#  id            :bigint           not null, primary key
#  name          :string
#  notes         :string
#  image_url     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint
#
class Meal < ApplicationRecord
  belongs_to :reviews

  validates :name, :notes, presence: true
end
