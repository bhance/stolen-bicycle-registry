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
    date                '03/15/2011'
    city                'Vancouver'
    region              'OR'
    description         'This is my bike'
    country             'United States'
    serial              'ZB23R45'
    verified_ownership  false
    police_report       'OR-12304'
    reward              300
    year                2002 
    brand               'Rivendell'
    model               'Aquarius'
    color               'Seafoam Green'
    size                54
    size_type           'cm'
    zip                 '97212'
  end

  factory :canadian, class: Bicycle do
    country 'Canada'
    region  'BC'
  end   
end
