FactoryGirl.define do
  factory :user do
    first_name "Joe"
    last_name "Bike"
    phone1 "555-555-5555"
    phone2 "999-999-9999"
    password "foosbars"
    password_confirmation "foosbars"

    factory :american_user do
      sequence(:email) { |n| "test1_#{n}@example.com"}
      country "United States"
      city "Portland"
      region "OR"
      postal_code "55555"
    end
    factory :canadian_user do
      sequence(:email) { |n| "canadian_serf_#{n}@example.com"}
      country "Canada"
      city "Toronto"
      region "ON"
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
    sequence(:serial) { |s| "ZC13fy5#{s}" }
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
      user { FactoryGirl.create(:canadian_user) }
      country 'Canada'
      region  'BC'
      postal_code 'A0A-0A0'
    end

    factory :recovered_bicycle, class: Bicycle do
      user { FactoryGirl.create(:canadian_user) }
      country 'Canada'
      region  'BC'
      recovered true
      postal_code 'A0A-0A0'
    end
  end
end
