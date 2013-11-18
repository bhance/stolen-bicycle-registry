class Import < ActiveRecord::Base

  def add
    CSV.foreach(file.path, headers: true) do |row|
      Bicycle.create! row.to_hash
    end
  end
end
