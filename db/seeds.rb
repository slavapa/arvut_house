#encoding: utf-8

@connection = ActiveRecord::Base.connection

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

def make_event_types
  EventType.create!(name:'שיעור בוקר')
  EventType.create!(name:'ישיבת חברים')
  EventType.create!(name:'מפגש ביום ראשון')
  EventType.create!(name:'מפגש ביום שלישי')
  EventType.create!(name:'סעודה')
end

def make_languages_by_sql 
  ActiveRecord::Base.transaction do
    @connection.execute("INSERT INTO languages (name, code) VALUES ('Spanish','es')")
    @connection.execute("INSERT INTO languages (name, code) VALUES ('עברית','he')")
  end
end


def make_language
  Language.create!(name:'אנגלית', code:'en')
  Language.create!(name:'רוסית', code:'ru')
  Language.create!(name:'עברית', code:'he')
  Language.create!(name:'צרפתית', code:'fr')
  Language.create!(name:'ספרדית', code:'es')
end

def make_statuses
  Status.create!(name:'פעיל/ה')
  Status.create!(name:'נקלט')
end

  
def make_events
  ev_type_inx = 0
  4.times do |n|
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
  
  Person.create!(name: "Haifa", family_name:'Arvut House',
                       email:    "haifa@arvuthouse.org",
                       password: "xxxxxx",
                       password_confirmation: "xxxxxx",
                       admin: true)
  
end

def populate_people_by_sql_file   
  sql = File.read('db/populate_people.sql')
  statements = sql.split(/;$/)
  #statements.pop  # the last empty statement
   
  ActiveRecord::Base.transaction do
    statements.each do |statement|
      @connection.execute(statement)
    end
  end
  # @connection.execute(sql)
  # sql = ""
  # source = File.new("./db/populate_people.sql", "r")
  # while (line = source.gets)
    # sql << line
  # end
  # source.close
  # @connection.execute(sql)
end

def populate_person_languages_by_sql_file
  files_arr = ['db/person_languages_eng.sql', 'db/person_languages_fr_es.sql', 
                'db/person_languages_heb.sql', 'db/person_languages_russion.sql'] 
                
  files_arr.each do |file_name|              
    sql = File.read(file_name)    
    statements = sql.split(/;$/)
     
    ActiveRecord::Base.transaction do
      statements.each do |statement|
        @connection.execute(statement)
      end
    end    
  end  
end


make_statuses
make_language
make_event_types
make_users
make_events
populate_people_by_sql_file
populate_person_languages_by_sql_file
 

