namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_stitches
    #make_relationships
  end
end

def make_users
  admin = User.create!(name: "Doug Allen",
                       username: "stitchdoug",
                       email: "doug@turino.tv",
                       password: "TacoBell123",
                       password_confirmation: "TacoBell123")
  admin.toggle!(:admin)
  #99.times do |n|
  50.times do |n|
    name = Faker::Name.name
    username = "exampleuser#{n+1}"
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                 username: username,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_stitches
  users = User.all(limit: 6)
  5.times do
    name = Faker::Lorem.words(3)
    description = Faker::Lorem.sentence(3)
    notes = Faker::Lorem.sentence(5)
    users.each { | user| user.stitches.create!(name: name, description: description, notes: notes) }
  end
end
#
#def make_relationships
#  users = User.all
#  user = users.first
#  followed_users = users[2..50]
#  followers = users[3..40]
#  followed_users.each { |followed| user.follow!(followed) }
#  followers.each { |follower| follower.follow!(user) }
#end