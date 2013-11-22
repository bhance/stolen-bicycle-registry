require 'spec_helper'

describe Import do
  describe '#new' do
    it 'adds users from a CSV file' do
      @import = Import.new(File.join(Rails.root, 'spec/CSVs/good_user_test.csv'))
      User.all.count.should eq 1
    end

    it 'adds users and bicycles from a CSV file' do
      Import.new(File.join(Rails.root, 'spec/CSVs/good_user_test.csv'), 
                 File.join(Rails.root, 'spec/CSVs/good_bicycle_test.csv'))
      Bicycle.all.count.should eq 1
    end
  end
end
