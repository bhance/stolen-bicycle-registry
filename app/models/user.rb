class User < ActiveRecord::Base
  include Geography
  acts_as_paranoid
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bicycles, inverse_of: :user
  accepts_nested_attributes_for :bicycles

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true
  validates :email, uniqueness: true 
  validates :phone1, format: { with: /\A[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}\z/ }, allow_nil: true, allow_blank: true
  validates :phone2, format: { with: /\A[(]{0,1}[0-9]{3}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}\z/ }, allow_nil: true, allow_blank: true
  validates :postal_code, presence: true

  def relevant_bicycles
    if admin?
      Bicycle.where(approved: false).order('date DESC')
    else
      bicycles
    end
  end
end
