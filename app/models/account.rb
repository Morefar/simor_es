class Account < ActiveRecord::Base
  attr_accessible :organization_name, :subdomain, :users
  # accepts_nested_attributes_for :users, limit: 1
  has_many :users
  validates :organization_name, :subdomain, presence: true
  validates :subdomain, format: { with: /\A[\p{Ll}\p{Pd}]+\d*\Z/iu }
end
