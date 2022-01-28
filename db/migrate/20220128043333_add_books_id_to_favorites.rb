class AddBooksIdToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :books_id, :integer
  end
end
