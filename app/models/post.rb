class Post < ApplicationRecord
  has_many :comments
  has_many :upvotes
  has_many :upvoted_by, through: :upvotes, source: :user
end
