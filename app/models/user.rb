class User < ActiveRecord::Base

  include Geography
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :region, presence: true
  validates :region, :inclusion => { :in => Geography::STATES, :if => :in_us? }
  validates :region, :inclusion => { :in => Geography::PROVINCES, :if => :in_canada? } 
  validates :postal_code, presence: true
  validates :encrypted_password, presence: true
  validates :email, uniqueness: true
  validate :correct_postal_code, before_save 

  has_many :bicycles
end
