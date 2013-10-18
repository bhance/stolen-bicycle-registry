class Bicycle < ActiveRecord::Base
  before_save :right_postal_code, :convert_year

  validates_presence_of :date
  validates :region, presence: true, inclusion: { in: PROVINCES + STATES }
  validates_presence_of :city
  validates :description, presence: true, length: { minimum: 30, maximum: 2000 }
  validates :postal_code, allow_nil: true, numericality: true, length: { is: 5 }, if: :us?
  validates :postal_code, allow_nil: true, length: { is: 7 }, if: :canada?
  validates_inclusion_of(:size_type, :in => %w( cm in ))
  validates_uniqueness_of :serial, allow_nil: true, allow_blank: true
  validates :country, presence: true

  has_attached_file :photo,
                    :styles => {
                            :medium => "300x300>",
                            :thumb => "100x100>" },
                    :default_url => "bike_:style.png"
  belongs_to :user

  private

  def us?
    country == 'United States'
  end

  def canada?
    country == 'Canada'
  end

  def right_postal_code
    if us? && /^\d{5}(-\d{4})?$/.match(postal_code)
      errors.add(:base, "Postal code must be five numbers")
    elsif canada? && /^\D{1}\d{1}\D{1}(\s|-)?\d{1}\D{1}\d{1}$/.match(postal_code)
      errors.add(:base, "Postal code must be in this format 'A0A 0A0'")
    end
  end

  def convert_year
    year.to_s
  end
 
  def self.bicycle_search(query)
    self.strip_empty_values(query)
    if query.class != String && query['recovered']
      query.delete_if { |k, v| v == '1' }
      query.present? ? fuzzy_search(query).where(hidden: false) : nil
    else
      query.present? ? fuzzy_search(query).where(hidden: false, recovered: false) : nil
    end
  end
  
  def self.strip_empty_values(query)
    if query.present? && query.class != String
      query.delete_if { |k, v| v.blank? }
      query.delete_if { |k, v| v == '0' }
    end
  end

end
