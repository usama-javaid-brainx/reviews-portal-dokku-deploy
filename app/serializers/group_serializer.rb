class GroupSerializer < ActiveModel::Serializer

  has_many :reviews
  def attributes(*args)
    object.attributes.symbolize_keys
  end
end
