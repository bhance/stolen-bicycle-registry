require 'spec_helper'

describe UserImport do
  describe '#new' do
    before do
      @import = UserImport.new(File.join(Rails.root, 'spec/CSVs/good_user_test.csv'))
    end

    it 'adds users from a CSV file' do
      User.all.count.should eq 1
    end
  end

  describe '#csv' do
    before do
      @import = UserImport.new(File.join(Rails.root, 'spec/CSVs/good_user_test.csv'))
    end

    it 'returns a CSV' do
      @import.csv.should eq []
    end
  end
end
