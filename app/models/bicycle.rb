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
  #fixme add default scope to hide hidden and recovered

private

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
