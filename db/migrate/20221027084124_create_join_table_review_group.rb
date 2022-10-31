class CreateJoinTableReviewGroup < ActiveRecord::Migration[7.0]
  def change
    create_join_table :reviews, :groups do |t|
      t.index [:review_id, :group_id]
    end
  end
end
