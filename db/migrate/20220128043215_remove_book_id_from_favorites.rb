class RemoveBookIdFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :book_id, :integer
  end
end
