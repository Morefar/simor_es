class Right < ActiveRecord::Base
  attr_accessible :operation, :resource
  has_many :grants
  has_many :roles, through: :grants
end
