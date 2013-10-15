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

  factory :bicycle do
    sequence(:date) { |d| "#{d < 32 ? d : d/2}/3/2011" }
    city 'Vancouver'
    region 'WA'
    description 'This is my bike. It was stolen on Wednesday, by the parking lot of Walmart at Gringo Station. There is a death to bike theives sticker on it. Please help!'
    country 'United States'
    sequence(:serial) { |s| "ZB23R45#{s}" }
    verified_ownership false
    sequence(:police_report) { |p| "WA-12#{p}304#{p+1}" }
    reward 100
    year 2002 
    brand 'Rivendell'
    model 'Aquarius'
    color 'Seafoam Green'
    size 54
    size_type 'cm'
    postal_code '97212'
  end

  factory :canadian, class: Bicycle do
    country 'Canada'
    region  'BC'
  end   
end
