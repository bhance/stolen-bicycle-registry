STATE_ABBREVIATIONS =  ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY', 'AS', 'DC', 'FM', 'GU', 'MH', 'MP', 'PW', 'PR', 'VI', 'AA', 'AE', 'AP']
PROVINCES = ['Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland', 'Northwest Territories', 'Nova Scotia', 'Nunavut', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan', 'Yukon' ]

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :region, presence: true
  validates_inclusion_of :region, :in => PROVINCES, :if => :in_canada?
  validates_inclusion_of :region, :in => STATE_ABBREVIATIONS, :if => :in_us? 
  validates :postal_code, presence: true
  validate :right_postal_code
  validates :encrypted_password, presence: true

  validates :email, uniqueness: true
  has_many :bicycles

private

  def right_postal_code
    if in_us? && !(/^\d{5}(-\d{4})?$/.match(postal_code))
      errors.add(:postal_code, "Postal code must be five numbers")
    elsif in_canada? && !(/^\D{1}\d{1}\D{1}(\s|-)?\d{1}\D{1}\d{1}$/.match(postal_code))
      errors.add(:postal_code, "Postal code must be in this format 'A0A 0A0'")
    end
  end

  def in_us?
    country == 'USA'
  end

  def in_canada?
    country == 'Canada'
  end
end
