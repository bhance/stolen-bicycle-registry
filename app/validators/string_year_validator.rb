class StringYearValidator < ActiveModel::Validator
  def validate(record)
    if ((record.year.to_i + 100) < Time.now.year || record.year.to_i > Time.now.year + 1) && !(record.year.blank?) #break into 3 private methods
      record.errors[:base] << "The manufacturing date must be within the last 100 years"
    end
  end
end
