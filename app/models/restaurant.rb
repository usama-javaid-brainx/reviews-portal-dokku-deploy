# == Schema Information
#
# Table name: restaurants
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  name             :string           not null
#  address          :string
#  city             :string           not null
#  state            :string
#  country          :string
#  place_id         :string
#  longitude        :string
#  latitude         :string
#  cuisine          :string
#  favorite_dish    :string
#  average_score    :float
#  notes            :text
#  date             :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  foursqaure_score :float
#  foursqaure_url   :string
#  foursqaure_id    :string
#  zip_code         :string           default("")
#  tags             :string           default("")
#  price_range      :integer
#  status           :integer
#  favourite        :boolean
#  shareable        :boolean
#  images           :json
#
class Restaurant < ApplicationRecord

  attr_accessor :images_input

  belongs_to :user
  has_many :meals, dependent: :destroy

  store_accessor :images, []

  # has_many_attached :images

  validates :name, :country, :average_score, :cuisine, presence: true
  # validates :name, :country, :average_score, :cuisine, :date, presence: true  (Remove Date, as it is not coming from front end)

  accepts_nested_attributes_for :meals

  def google_maps_link
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end
end
