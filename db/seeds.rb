require 'open-uri'
require 'json'
require 'faker'

puts "deleting all records"
User.delete_all
Post.delete_all

puts "Creating Users"
50.times do
  User.new(email: Faker::Internet.email, password: 'password', username: Faker::Internet.username).save
end
User.new(email: 'test@test.fr', password: 'password', username: 'test').save

puts "Catching the Posts ids"
url = "https://hacker-news.firebaseio.com/v0/topstories.json"
ids_serialized = URI.parse(url).read
ids = JSON.parse(ids_serialized)

puts "creating Posts"
url = "https://hacker-news.firebaseio.com/v0/item/"
ids.first(50).each do |id|
  post_serialized = URI.parse(url + id.to_s + ".json").read
  post = JSON.parse(post_serialized)
  Post.new(post_type: post["type"], author: post["by"], title: post["title"], url: post["url"]).save
end

puts "creating Comments"
post_ids = Post.pluck(:id)
user_ids = User.pluck(:id)
150.times do
  Comment.new(post_id: post_ids.sample, user_id: user_ids.sample, content: Faker::Quote.famous_last_words).save
end

puts "creating upvotes"
post_ids = Post.pluck(:id)
user_ids = User.pluck(:id)
200.times do
  Upvote.new(post_id: post_ids.sample, user_id: user_ids.sample).save
end

puts "calculating scores"
Post.all.each do |post|
  post.update(score: post.upvotes.count)
end
