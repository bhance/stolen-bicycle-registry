# This will guess the User class
FactoryGirl.define do
  factory :bicycle do
    date                '03/15/2011'
    city                'Portland'
    state               'OR'
    description         'This is my bike'

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
end
