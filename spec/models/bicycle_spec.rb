require 'spec_helper'

state_abbreviations =  ['AL', 'AK', 'AZ', 'AR', 'CA', 
                        'CO', 'CT', 'DE', 'FL', 'GA', 
                        'HI', 'ID', 'IL', 'IN', 'IA', 
                        'KS', 'KY', 'LA', 'ME', 'MD', 
                        'MA', 'MI', 'MN', 'MS', 'MO', 
                        'MT', 'NE', 'NV', 'NH', 'NJ', 
                        'NM', 'NY', 'NC', 'ND', 'OH', 
                        'OK', 'OR', 'PA', 'RI', 'SC', 
                        'SD', 'TN', 'TX', 'UT', 'VT', 
                        'VA', 'WA', 'WV', 'WI', 'WY', 
                        'AS', 'DC', 'FM', 'GU', 'MH', 
                        'MP', 'PW', 'PR', 'VI', 'AA', 
                        'AE', 'AP']

describe Bicycle do
  # it { should belong_to :user }
  it { should validate_presence_of :date }
  it { should validate_presence_of :state }  
  it { should validate_presence_of :city }
  it { should validate_presence_of :description }
  it { should validate_numericality_of :zip }
  it { should ensure_inclusion_of(:state).in_array(state_abbreviations) }
  it { should ensure_inclusion_of(:size_type).in_array(['cm', 'in']) }
  it { should ensure_uniqueness_of :serial }
  it { should ensure_length_of(:description).
              is_at_least(30).
              is_at_most(2000) }
  it { should validate_numericality_of :year }
  it { should ensure_length_of(:year).is(4) }
end

