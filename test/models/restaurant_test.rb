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
require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
