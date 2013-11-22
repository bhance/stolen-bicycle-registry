class UserImport
  attr_accessor :csv

  def initialize(file)
    csv = [['oid', 'id']]
    rows = SmarterCSV.process(file)
    rows.each do |row|
      row[:postal_code] = row[:postal_code].to_s
      User.invite!(row)
    end
  end
end
