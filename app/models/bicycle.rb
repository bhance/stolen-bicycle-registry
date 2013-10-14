class Bicycle < ActiveRecord::Base
  before_save :right_postal_code

  validates_presence_of :date
  validates :region, presence: true, inclusion: { in: %w( AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY AS DC FM GU MH MP PW PR VI AA AE AP ) }
  validates_presence_of :city
  validates :description, presence: true, length: { minimum: 30, maximum: 2000 }
  validates :postal_code, allow_nil: true, numericality: true, length: { is: 5 }, if: :us?
  validates :postal_code, allow_nil: true, length: { is: 7 }, if: :canada?
  validates_inclusion_of(:size_type, :in => %w( cm in ))
  validates_uniqueness_of :serial
  validates :year, numericality: true, inclusion: { in: (0..2100) }, allow_nil: true
  validates :country, presence: true

  has_attached_file :photo, 
                    :styles => { 
                             :medium => "300x300>", 
                             :thumb => "100x100>" }, 
                    :default_url => "/images/:style/missing.png"

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
end
