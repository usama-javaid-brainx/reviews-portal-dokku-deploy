class Group < ApplicationRecord

  has_and_belongs_to_many :reviews
  belongs_to :user

end
