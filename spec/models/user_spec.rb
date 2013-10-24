require 'spec_helper'

describe User do
  it { should respond_to :first_name }
  it { should respond_to :first_name_public }
  it { should respond_to :last_name }
  it { should respond_to :last_name_public }
  it { should respond_to :email }
  it { should respond_to :email_public }
  it { should respond_to :phone1 }
  it { should respond_to :phone2 }
  it { should respond_to :encrypted_password }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :postal_code }
  it { should validate_presence_of :email }
  it { should validate_presence_of :encrypted_password}

  it { should validate_uniqueness_of :email }
  it { should have_many :bicycles }

  it "should set 'first_name_public' to true if the user checks the box on sign up/update" do
    user = FactoryGirl.create(:american_user, first_name_public: false)
    user.first_name_public.should be false
    user.update(first_name_public: true)
    user.first_name_public.should be true
  end

  it "should set 'last_name_public' to true if the user checks the box on sign up/update" do
    user = FactoryGirl.create(:american_user, last_name_public: false)
    user.last_name_public.should be false
    user.update(last_name_public: true)
    user.last_name_public.should be true
  end

  it "should set 'email_public' to true if the user checks the box on sign up" do
    user = FactoryGirl.create(:american_user, email_public: false)
    user.email_public.should be false
    user.update(email_public: true)
    user.email_public.should be true
  end

  describe "Canadian address verification" do
    it 'ensures that the selected region is a valid Canadian province' do
      user = FactoryGirl.build(:canadian_user)
      user.should ensure_inclusion_of(:region).in_array(Geography::PROVINCES)
    end
  end

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
