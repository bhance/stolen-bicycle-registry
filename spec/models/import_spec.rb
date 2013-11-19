require 'spec_helper'

describe Import do
  describe '#new' do
    it 'adds bicycles from a CSV file' do
      Import.new(File.join(Rails.root, 'spec/CSVs/good_test.csv'))
      Bicycle.all.count.should eq 1
    end
  end
end
