FactoryGirl.define do
  factory :person do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "xxxxxx"
    password_confirmation "xxxxxx"
    admin true
    
    factory :admin do
      admin true
    end
  end

  factory :event_type do
    sequence(:name)  { |n| "Event Type #{n}" }
  end
  
  factory :event do
    sequence(:description)  { |n| "Event Description #{n}" }
    event_date = Date.today
    event_type 
  end
  
  factory :person_event_relationship do
    event
    person
  end
   
  factory :person_language do
    language
    person
  end
  
  factory :role do
    sequence(:name)  { |n| "Role #{n}" }
  end
   
  factory :department do
    sequence(:name)  { |n| "Department #{n}" }
  end
  
  factory :language do
    name = 'language1'
    code = 'aa'
  end
   
  factory :payment_type do
    sequence(:name)  { |n| "Payment Types factory #{n}" }
    frequency = 1
    amount = 15
  end
   
  factory :person_payment do
    payment
    person
  end
   
  factory :payment do
    sequence(:description)  { |n| "Payment Description #{n}" }
    payment_date = Date.today
    payment_type 
  end
end
