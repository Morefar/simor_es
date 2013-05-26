class Entity < ActiveRecord::Base
  attr_accessible :address, :city, :email, :identification_type_id, :identification_number_id, :mobile_phone, :name, :phone, :state
  belongs_to :indentification_type
  has_many :cosigners
  has_many :contracts
  has_many :contracts, through: :cosigners
end
