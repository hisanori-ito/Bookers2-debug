class RemoveBooksIdFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :books_id, :integer
  end
end
