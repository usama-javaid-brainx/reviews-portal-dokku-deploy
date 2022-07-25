# == Schema Information
#
# Table name: restaurants
#
#  id            :bigint           not null, primary key
#  user_id       :bigint
#  name          :string           not null
#  address       :string
#  city          :string           not null
#  state         :string
#  country       :string
#  place_id      :string
#  longitude     :string
#  latitude      :string
#  cuisine       :string
#  favorite_dish :string
#  average_score :float
#  notes         :text
#  date          :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  zip_code      :string           default("")
#  tags          :string           default("")
#  price_range   :integer
#  status        :integer
#  favourite     :boolean
#  shareable     :boolean
#
class Restaurant < ApplicationRecord

  belongs_to :user
  has_many :meals

  has_many_attached :images

  validates :name, :country, :average_score, :cuisine, :date, presence: true

  def google_maps_link
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end
end
