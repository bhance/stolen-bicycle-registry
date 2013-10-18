class StringYearValidator < ActiveModel::Validator
  def validate(record)
    if (record.year.to_i + 100 < (Time.now.year) || record.year.to_i > Time.now.year) && !(record.year.blank?)
      record.errors[:base] << "The year must be within 100 years before today"
    end
  end
end