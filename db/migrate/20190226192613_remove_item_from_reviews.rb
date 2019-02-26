class RemoveItemFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_reference :reviews, :item, foreign_key: true
  end
end
