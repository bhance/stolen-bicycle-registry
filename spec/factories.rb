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
    sequence(:email) { |n| "canadian_person_#{n}@example.com"}    
    country "Canada"
    city "City"
    region "Manitoba"
    postal_code "R0J 0A0"
    password "foosbars"
    password_confirmation "foosbars"
  end

  factory :bicycle do
    date                '03/12/2011'
    city                'Vancouver'
    region              'WA'
    description         'I went to get groceries at Safeway and when I came back out  my bike was gone'
    country             'United States'
    serial              'ZB23R45'
    verified_ownership  false
    police_report       'OR-12304'
    reward              300
    year                2002 
    brand               'Rivendell'
    model               'Atlantis'
    color               'Seafoam Green'
    size                54
    size_type           'cm'
    postal_code         '97212'
  end

  factory :canadian, class: Bicycle do
    country 'Canada'
    region  'BC'
  end

  # factory :user_and_bicycle do
  #   user = create(:american_user)
  #   bicycle = create(:bicycle, user_id: user.id)
  # end 
end
