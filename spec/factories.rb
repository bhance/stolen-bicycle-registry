FactoryGirl.define do
  factory :user do
    first_name "First_name"
    last_name "Last_name"
    password "foosbars"
    password_confirmation "foosbars"

    factory :american_user do
      sequence(:email) { |n| "person_#{n}@example.com"}
      country "USA"
      city "City"
      region "OR"
      postal_code "55555"
      
    end

    factory :canadian_user do
      sequence(:email) { |n| "canadian_person_#{n}@example.com"}    
      country "Canada"
      city "City"
      region "MB"
      postal_code "R0J 0A0"
    end
  end
  

  factory :bicycle do
    user { FactoryGirl.create(:american_user) }
    date '5/3/2011' 
    city 'Vancouver'
    region 'WA'
    description 'This is my bike. It was stolen on Wednesday, by the parking lot of Walmart at Gringo Station. There is a death to bike theives sticker on it. Please help!'
    country 'United States'
    sequence(:serial) { |s| "ZC23R45#{s}" }
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
  
    factory :canadian_bicycle, class: Bicycle do
      canadian_user { FactoryGirl.create(:canadian_user) }
      country 'Canada'
      region  'BC'
    end
  end
end
