class PostalCodeValidator < ActiveModel::Validator
  def validate(record)
    if record.in_us? && !(/^\d{5}(-\d{4})?$/.match(record.postal_code))
      record.errors.add(:postal_code, "must be five numbers")
    elsif record.in_canada? && !(/^\D{1}\d{1}\D{1}(\s|-)?\d{1}\D{1}\d{1}$/.match(record.postal_code))
      record.errors.add(:postal_code, "must be in this format 'A0A 0A0'")
    end
  end
end


