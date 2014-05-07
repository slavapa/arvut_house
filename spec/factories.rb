FactoryGirl.define do
  # factory :person do
    # sequence(:name)  { |n| "Person #{n}" }
    # sequence(:email) { |n| "person_#{n}@example.com"}
    # password "xxxxxx"
    # password_confirmation "xxxxxx"
# 	
    # factory :admin do
      # admin true
    # end
  # end  
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
  end
end
