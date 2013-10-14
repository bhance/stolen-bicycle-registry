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
  it { should respond_to :state }
  it { should respond_to :zip }
  it { should respond_to :phone1 }
  it { should respond_to :phone2 }

  it { should validate_uniqueness_of :email }
end

