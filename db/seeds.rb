require 'open-uri'
require 'json'
require 'faker'

puts "deleting all records"
User.delete_all

puts "Creating Users"
User.new(email: 'user1@test.fr', password: 'password', username: 'user1').save
User.new(email: 'user2@test.fr', password: 'password', username: 'user2').save
User.new(email: 'user3@test.fr', password: 'password', username: 'user3').save

puts "Catching the Posts ids"
url = "https://hacker-news.firebaseio.com/v0/topstories.json"
ids_serialized = URI.parse(url).read
ids = JSON.parse(ids_serialized)

puts "creating Posts"
url = "https://hacker-news.firebaseio.com/v0/item/"
ids.first(50).each do |id|
  post_serialized = URI.parse(url + id.to_s + ".json").read
  post = JSON.parse(post_serialized)
  Post.new(score: post["score"], post_type: post["type"], author: post["by"], title: post["title"], url: post["url"]).save
end

puts "creating Comments"
post_ids = Post.pluck(:id)
user_ids = User.pluck(:id)
150.times do
  Comment.new(post_id: post_ids.sample, user_id: user_ids.sample, content: Faker::Quote.famous_last_words).save
end
