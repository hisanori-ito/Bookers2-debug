class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :post_books
end
