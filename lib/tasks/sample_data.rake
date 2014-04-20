namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_events
  end
end

def make_users  
  admin = Person.create!(name:     "Example User", family_name:'Railstutorial',
                       email:    "example@railstutorial.org",
                       password: "xxxxxx",
                       password_confirmation: "xxxxxx",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.first_name
    family_name = Faker::Name.last_name
    email = "example-#{n+1}@railstutorial.org"
    password  = "xxxxxx"
    Person.create!(name:     name, family_name: family_name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
  
end

def make_events
  50.times do |n|
    name  = "#{n+1} Event"
    description = "#{n+1} Event example-description"
    event_date =  Date.today + n.days
    Event.create!(name:     name,
                 description:    description)
  end
end


