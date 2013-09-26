class Entity < ActiveRecord::Base

  attr_accessible :address, :city, :email, :identification_type_id, :identification_number, :mobile_phone, :name, :phone, :state
  belongs_to :identification_type
  has_many :cosigners
  has_many :contracts, through: :cosigners

  validates :address, :city, :state, :phone, :identification_number, :identification_type_id, :name, :email, presence: true
  validates :identification_number, uniqueness: { scope: :identification_type_id }
  validates :email, uniqueness: { scope: :identification_type_id, case_sensitive: true }
  validates :email, format: { with: /\A[a-zA-Z_.]+@[.a-zA-Z\-_]+\Z/ }

  scope :search_name, ->(term) { where("name ilike ?", term) }
  def contracts_as_lessee
    Array( Contract.where(lessee_id: id) )
  end

  def contracts_as_cosigner
    contracts
  end

end
