class CreateBookTags < ActiveRecord::Migration[6.1]
  def change
    create_table :book_tags do |t|
      t.references :post
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
