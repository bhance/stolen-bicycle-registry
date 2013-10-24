class User < ActiveRecord::Base
  include Geography
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true
  validates :email, uniqueness: true 
  validates :phone1, format: { with: /\A[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}\z/ }, allow_nil: true, allow_blank: true
  validates :phone2, format: { with: /\A[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}\z/ }, allow_nil: true, allow_blank: true
  validates :postal_code, presence: true
  has_many :bicycles
end
