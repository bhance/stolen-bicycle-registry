class Bicycle < ActiveRecord::Base

  include Geography

  has_attached_file :photo,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" },
                    :default_url => "bike_:style.png"
  
  belongs_to :user

  #fixme validate user_id presence
  validates_presence_of :date
  validates :description, presence: true, length: { minimum: 30, maximum: 2000 }
  validates_inclusion_of(:size_type, :in => %w( cm in ))
  validates_uniqueness_of :serial, allow_nil: true, allow_blank: true
  validates_with StringYearValidator
  # validates :year, numericality: true, inclusion: { in: (0..2100) }, allow_nil: true
  before_save :convert_year

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
