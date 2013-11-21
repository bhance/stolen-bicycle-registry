class BicycleImport

  def initialize(file)
    rows = SmarterCSV.process(file)
    rows.each do |row|
      Bicycle.create(row)
    end
  end
end
