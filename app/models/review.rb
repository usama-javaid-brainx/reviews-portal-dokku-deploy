# == Schema Information
#
# Table name: reviews
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
class Review < ApplicationRecord
  include Discard::Model
  extend FriendlyId
  friendly_id :slug_candidates

  default_scope -> { kept }

  scope :all_except, ->(review) { where.not(id: review) }

  attr_accessor :images_input
  store_accessor :images, []

  belongs_to :user
  has_and_belongs_to_many :groups
  belongs_to :category
  has_many :meals, dependent: :destroy

  validates :name, presence: true
  # only require name to create review

  accepts_nested_attributes_for :meals

  def google_maps_link
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end

  def should_generate_new_friendly_id?
    name_changed? || slug.nil?
  end

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :state],
      [:name, :city, :state, :country],
      [:name, :id]
    ]
  end
end

