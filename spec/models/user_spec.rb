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
  it { should respond_to :encrypted_password }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :country }
  it { should validate_presence_of :city }
  it { should validate_presence_of :state }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :email }
  it { should validate_presence_of :encrypted_password}

  it { should validate_uniqueness_of :email }
end

