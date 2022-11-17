class Group < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  has_and_belongs_to_many :reviews
  belongs_to :user

  accepts_nested_attributes_for :reviews

end
