require 'spec_helper'

describe User do
  it { should respond_to :first_name }
  it { should respond_to :first_name_public }
  it { should respond_to :last_name }
  it { should respond_to :last_name_public }
  it { should respond_to :email }
  it { should respond_to :email_public }
  it { should respond_to :country }
  it { should respond_to :city }
  it { should respond_to :region }
  it { should respond_to :postal_code }
  it { should respond_to :phone1 }
  it { should respond_to :phone2 }
  it { should respond_to :encrypted_password }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :country }
  it { should validate_presence_of :city }
  it { should validate_presence_of :region }
  it { should validate_presence_of :postal_code }
  it { should validate_presence_of :email }
  it { should validate_presence_of :encrypted_password}

  it { should validate_uniqueness_of :email }
  it { should have_many :bicycles }

  describe "Phone Number validation" do
    let(:user) { FactoryGirl.build(:user) }

    it 'allows 10 digit phone numbers with dashes' do
      user.should allow_value("555-555-5555").for(:phone1)
    end

    it 'allows 10 digit phone numbers without dashes' do
      user.should allow_value("9999999999").for(:phone2)
    end

    it 'does not allow phone numbers lacking 10 digits' do
      user.should_not allow_value("55-555-5555").for(:phone1)
    end

    it 'does not allow phone numbers with non-numeric characters' do
      user.should_not allow_value("999-9A9-9999").for(:phone1)
    end
  end
end
