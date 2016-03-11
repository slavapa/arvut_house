FactoryGirl.define do
  factory :person do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:family_name)  { |n| "Family_name_#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "xxxxxx"
    password_confirmation "xxxxxx"
    admin true

    factory :admin do
      admin true
    end
    
    factory :guest do
      org_relation_status_id OrgRelationStatus::GUEST
      password nil
      password_confirmation nil
      admin false
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
    sequence(:description)  { |n| "Department description #{n}" }
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

  factory :department_person_role do
    department
    person
    role
  end
  
  factory :org_relation_status do
    sequence(:name)  { |n| "Organization Reletion Status #{n}" }
    sequence(:description)  { |n| "Organization Reletion Status description #{n}" }
  end
end
