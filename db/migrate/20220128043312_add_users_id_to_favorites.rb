class AddUsersIdToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :users_id, :integer
  end
end
