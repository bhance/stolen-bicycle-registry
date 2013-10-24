class ActiveRecord::Base
  def self.none
    where(id: nil)
  end
end
