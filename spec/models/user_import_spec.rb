require 'spec_helper'

describe UserImport do
  describe '#new' do
    it 'adds users from a CSV file' do
      UserImport.new(File.join(Rails.root, 'spec/CSVs/good_user_test.csv'))
      User.all.count.should eq 1
    end
  end
end
