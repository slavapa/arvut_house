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
end


