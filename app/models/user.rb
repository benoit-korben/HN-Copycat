class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :upvotes, dependent: :destroy
  has_many :upvoted_posts, through: :upvotes, source: :post
  has_many :reactions, dependent: :destroy
end
