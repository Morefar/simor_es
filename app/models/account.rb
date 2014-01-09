class Account < ActiveRecord::Base
  has_many :users
  validates :organization_name, :subdomain, presence: true
  validates :subdomain, format: { with: /\A[\p{Ll}\p{Pd}]+\d*\Z/iu }
end
