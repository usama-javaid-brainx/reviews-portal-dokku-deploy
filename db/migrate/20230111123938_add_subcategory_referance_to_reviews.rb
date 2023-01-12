class AddSubcategoryReferanceToReviews < ActiveRecord::Migration[7.0]
  def up
    add_reference :reviews, :sub_category, null: true , foreign_key: true
    Review.all.each do |review|
      review.update(sub_category_id: SubCategory.find_by(name: review.cuisine)&.id)
    end
    remove_column :reviews, :cuisine, :string
  end

  def down
    add_column :reviews, :cuisine, :string
    Review.all.each do |review|
      review.update(cuisine: SubCategory.find(review.sub_category_id)&.name) if review.sub_category_id.present?
    end
    remove_reference :reviews, :sub_category

  end
end
