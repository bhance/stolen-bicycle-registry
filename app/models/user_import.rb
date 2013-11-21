class UserImport

  def initialize(file)
    rows = SmarterCSV.process(file)
    rows.each do |row|
      row[:postal_code] = row[:postal_code].to_s
      binding.pry
      User.invite!(row)
    end
  end
end
