STATES =  ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'AS', 'DC', 'FM', 'GU', 'MH', 'MP', 'PW', 'PR', 'VI', 'AA', 'AE', 'AP']
PROVINCES = ['AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT']
#fixme move these constants to a module that is included in user and bicycle

class Bicycle < ActiveRecord::Base
  has_attached_file :photo,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" },
                    :default_url => "bike_:style.png"
  
  belongs_to :user

  # validate user_id presence
  validates_presence_of :date
  validates :region, presence: true, inclusion: { in: PROVINCES + STATES }
  validates_presence_of :city
  validates :description, presence: true, length: { minimum: 30, maximum: 2000 }
  validates :postal_code, allow_nil: true, numericality: true, length: { is: 5 }, if: :us?
  validates :postal_code, allow_nil: true, length: { is: 7 }, if: :canada?
  validates_inclusion_of(:size_type, :in => %w( cm in ))
  validates_uniqueness_of :serial, allow_nil: true, allow_blank: true
  validates_with StringYearValidator
  validates :country, presence: true

  before_save :right_postal_code, :convert_year

  def us? #fixme make consistent with user.rb and factor into geography module
    country == 'United States'
  end

  def canada? #fixme me too
    country == 'Canada'
  end

  def self.flexible_search(query)
    search_or_none(query, bicycle_scope(query))
  end

private

  def right_postal_code #fixme use same validator from User
    if us? && /^\d{5}(-\d{4})?$/.match(postal_code)
      errors.add(:base, "Postal code must be five numbers")
    elsif canada? && /^\D{1}\d{1}\D{1}(\s|-)?\d{1}\D{1}\d{1}$/.match(postal_code)
      errors.add(:base, "Postal code must be in this format 'A0A 0A0'")
    end
  end

  def convert_year
    year.to_s
  end

  def self.search_or_none(query, scope)
    strip_values(query)
    if query.present?
      fuzzy_search(query).where(scope)
    else
      Bicycle.none
    end
  end

  def self.bicycle_scope(query)
    if (query.class != String && query['recovered'] == '1') 
      { hidden: false } 
    else
      { hidden: false, recovered: false }
    end
  end
  
  def self.strip_values(query)
    if query.present? && query.class != String 
      query.delete_if { |k, v| v.blank? || v == '0' || v == '1' }
    end
  end
end
