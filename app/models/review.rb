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
  before_save :generate_slug, if: -> { slug.blank? }

  default_scope -> { kept }

  attr_accessor :images_input
  store_accessor :images, []

  belongs_to :user
  belongs_to :category
  has_many :meals, dependent: :destroy

  validates :name, presence: true
  # only require name to create review

  accepts_nested_attributes_for :meals

  def google_maps_link
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end

  def generate_slug
    self.slug = "#{SecureRandom.base58(32)}#{Review.last.id + 1}"
  end

  scope :default_order, ->(review) {

    Review.find_by_sql("SELECT * FROM #{review}
     ORDER BY
     (CASE
       WHEN date IS NOT NULL THEN date
       WHEN start_date IS NOT NULL THEN start_date
       ELSE created_at
     END) DESC")
  }

end

