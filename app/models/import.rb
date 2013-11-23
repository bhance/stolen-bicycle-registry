class Import
  def initialize(user_file, bicycle_file=nil)
    @join_table = {}
    create_join_table(user_file) if user_file
    create_bicycles(bicycle_file) if bicycle_file
  end

private
  def create_join_table(file)
    rows = SmarterCSV.process(file)
    rows.each do |row|
      oid = row.delete(:oid)
      row[:postal_code] = row[:postal_code].to_s
      id = User.invite!(row).id
      @join_table[oid] = id
    end
  end

  def create_bicycles(file)
    rows = SmarterCSV.process(file)
    rows.each do |row|
      row[:user_id] = @join_table[row[:owneroid]]
      row.delete(:owneroid)
      row[:date] = Date.strptime(row[:date], "%m/%d/%Y")
      Bicycle.create(row)
    end
  end
end
