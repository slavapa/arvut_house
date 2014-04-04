namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
  end
end

def make_users
  admin = Person.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "xxxxxx",
                       password_confirmation: "xxxxxx",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "xxxxxx"
    Person.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
  
  50.times do |n|
    name  = "#{n+1} Event"
    description = "#{n+1} Event example-description"
    Event.create!(name:     name,
                 description:    description)
  end
end


