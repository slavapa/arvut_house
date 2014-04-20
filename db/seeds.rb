# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Person.create!(name:'Slava', family_name:'Pasechnik', 
  email:'slavapas13@gmail.com', password:'xxxxxx', password_confirmation:'xxxxxx',
  admin: true)
