class Import

  def initialize(file)
    rows = SmarterCSV.process(file)
    rows.each do |row|
      binding.pry
      Bicycle.create(row)
    end
  end
end
