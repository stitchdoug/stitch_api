namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_stitches
    make_images
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
    name = Faker::Lorem.sentence(2)
    description = Faker::Lorem.sentence(3)
    notes = Faker::Lorem.sentence(5)
    users.each { | user| user.stitches.create!(name: name, description: description, notes: notes) }
  end
end

def make_images
  stitch = User.first.stitches.first
  images = ['http://cdn.blog.malwarebytes.org/wp-content/uploads/2013/08/google-glass-macro.jpg',
            'http://i2.cdn.turner.com/cnn/dam/assets/130503103436-google-glass-scoble-horizontal-gallery.jpg',
            'http://blogs.independent.co.uk/wp-content/uploads/2013/02/google-glass-explorer.jpg',
            'http://venturebeat.files.wordpress.com/2013/05/google-glass1.jpg',
            'http://www.sellcell.com/blog/wp-content/uploads/2013/07/google-glass-price.jpg',
            'http://rack.0.mshcdn.com/media/ZgkyMDEzLzA1LzIwL2EyL0dvb2dsZUdsYXNzLmRiMjU2LmpwZwpwCXRodW1iCTk1MHg1MzQjCmUJanBn/c5646952/53b/Google-Glass-Future-Thumb.jpg',
            'http://influxis.com/wp-content/uploads/2013/05/google-glass-wallpaper-hd2.jpg']
  images.each do |image|
    stitch.images.create!(url: image)
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