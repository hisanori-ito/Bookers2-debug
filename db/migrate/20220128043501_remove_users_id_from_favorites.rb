class RemoveUsersIdFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :users_id, :integer
  end
end
