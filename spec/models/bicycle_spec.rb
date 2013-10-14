require 'spec_helper'

state_abbreviations =  ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'AS', 'DC', 'FM', 'GU', 'MH', 'MP', 'PW', 'PR', 'VI', 'AA', 'AE', 'AP']

describe Bicycle do
  it { should validate_presence_of :date }
  it { should validate_presence_of :state }  
  it { should validate_presence_of :city }
  it { should validate_numericality_of(:zip) }
  it { should ensure_inclusion_of(:state).in_array(state_abbreviations) }
  it { should ensure_inclusion_of(:size_type).in_array(['cm', 'in'])}
end

