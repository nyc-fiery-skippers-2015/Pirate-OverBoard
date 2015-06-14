# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

don = User.create(username:"Don" ,email:"don@gmail.com", password_digest:"12345")

25.times{Question.create(title:Faker::Hacker.adjective , body:Faker::Hacker.say_something_smart, user:don)}
