class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books

  validates :title, :author, :description, presence: true
  validates :title, uniqueness: { scope: :author }
end
