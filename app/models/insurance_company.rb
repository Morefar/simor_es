class InsuranceCompany < ActiveRecord::Base
  attr_accessible :name, :nit
  has_many :assets
end
