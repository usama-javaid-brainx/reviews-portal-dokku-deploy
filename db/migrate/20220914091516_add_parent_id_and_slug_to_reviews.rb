class AddParentIdAndSlugToReviews < ActiveRecord::Migration[7.0]
  def up
    add_column :reviews, :parent_id, :integer
    add_column :reviews, :slug, :string

    Review.all.each do |review|
      review.update(slug: SecureRandom.base58(32)) unless review.slug.present?
    end
  end
  def down
    remove_column :reviews, :slug, :string
    remove_column :reviews, :parent_id, :integer
  end


end
