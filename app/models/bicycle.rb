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
  # validates :year, numericality: true, inclusion: { in: (0..2100) }, allow_nil: true
  validates :country, presence: true

  before_save :right_postal_code, :convert_year

  #fixme add default scope to hide hidden and recovered

  def us? #fixme make consistent with user.rb and factor into geography module
    country == 'United States'
  end

  def canada? #fixme me too
    country == 'Canada'
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
 
  def self.bicycle_search(query) #fixme rename to something more descriptive, maybe flexible_search #fixme make public!
    self.strip_empty_values(query)
    # search_scope = self.set_proper_scope(query)
    # fuzzy_search(query).scope(scope)
    if query.class != String && query['recovered']
      query.delete_if { |k, v| v == '1' } #fixme extract to a well-named private method
      query.present? ? fuzzy_search(query).where(hidden: false) : nil #fixme after adding default scope, remove it by using Bicycle.unscoped.whatever_you_want_to_do
    else
      query.present? ? fuzzy_search(query).where(hidden: false, recovered: false) : nil
    end
  end

  # def set_proper_scope(query)
  #   if query.class != String && query['recovered']
  #     query['recovered'] = nil
  #     { recovered: true }
  #   end
  # end
  
  def self.strip_empty_values(query)
    if query.present? && query.class != String 
      query.delete_if { |k, v| v.blank? }
      query.delete_if { |k, v| v == '0' }
    end
  end
end
