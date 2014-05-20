namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_language
    make_event_types
    make_users
    make_events
  end
end

def make_users   
  
  Person.create!(name:'Slava', family_name:'Pasechnik', 
  email:'slavapas13@gmail.com', password:'xxxxxx', password_confirmation:'xxxxxx',
  admin: true)
  
  Person.create!(name:'Vladimir', family_name:'Rogachevsky', 
  email:'VladR@astea.co.il', password:'xxxxxx', password_confirmation:'xxxxxx',
  admin: true)
  
  Person.create!(name:'Kiril', family_name:'Rogachevsky', 
  email:'kirilsagoth2@gmail.com', password:'xxxxxx', password_confirmation:'xxxxxx',
  admin: true)
  
  admin = Person.create!(name:     "Haifa", family_name:'Arvut House',
                       email:    "haifa@arvuthouse.org",
                       password: "xxxxxx",
                       password_confirmation: "xxxxxx",
                       admin: true)
  # 99.times do |n|
    # name  = Faker::Name.first_name
    # family_name = Faker::Name.last_name
    # email = "example-#{n+1}@railstutorial.org"
    # password  = "xxxxxx"
    # Person.create!(name: name, family_name: family_name,
                 # email:    email, password: password,
                 # password_confirmation: password)
  # end
  
end

def event_types_name(event_type_id)
    event_types_array[event_type_id-1][0]
end

def get_event_types_id(event_type_id)
    event_types_array[event_type_id-1][1]
end

def event_types_array
  @event_types_array ||= 
    EventType.all.map { |event_type| [event_type.name, event_type.id] }
end  
  
def make_events
  ev_type_inx = 0
  50.times do |n|
    event_type_id = get_event_types_id(ev_type_inx)
    description = event_types_name(ev_type_inx)
    ev_type_inx = ev_type_inx + 1
    if ev_type_inx >= event_types_array.length 
      ev_type_inx=0
    end
    event_date =  Date.today.ago(1.year) + n.days
    Event.create!(event_type_id: event_type_id, description: description, event_date: event_date)
  end
end

def make_event_types
  EventType.create!(name:'Night Lesson')
  EventType.create!(name:'Meeting Friends')
  EventType.create!(name:'Tuesday Meeting')
  EventType.create!(name:'Repast')
end

def make_language
  Language.create!(name:'English', code:'en')
  Language.create!(name:'Russian', code:'ru')
  Language.create!(name:'Hebrew', code:'he')
end



