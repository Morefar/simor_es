class InsuranceCompany < ActiveRecord::Base
  attr_accessible :name, :nit
  has_many :inspections

  validates :name, :nit, presence: true
  validates :name, :nit, uniqueness: true
  validates :name, format: { with: /\A[\D]+[a-z.]+\Z/i }
  validates :nit, format: { with: /\A\d{3}([.]*)\d{3}\1\d{3}\Z/ }
  validates :nit, length: { within: 9..11 }
end
