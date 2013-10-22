
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
  validates_inclusion_of :region, :in => PROVINCES, :if => :in_canada? #fixme move to line 15 
  validates_inclusion_of :region, :in => STATES, :if => :in_us? #fixme move to line 15
  validates :postal_code, presence: true
  validates :encrypted_password, presence: true
  validates :email, uniqueness: true
  validate :right_postal_code #fixme move this to a validator
  #fixme validate :postal_code, :correct_postal_code => true #something like this

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
