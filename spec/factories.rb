FactoryGirl.define do
  factory :american_user, class: User do
    first_name "First_name"
    last_name "Last_name"
    sequence(:email) { |n| "person_#{n}@example.com"}
    country "USA"
    city "City"
    region "OR"
    postal_code "55555"
    password "foosbars"
    password_confirmation "foosbars"
  end

  factory :canadian_user, class: User do
    first_name "First_name"
    last_name "Last_name"
    sequence(:email) { |n| "person_#{n}@example.com"}    
    country "Canada"
    city "City"
    region "Manitoba"
    postal_code "R0J 0A0"
    password "foosbars"
    password_confirmation "foosbars"
  end
end
