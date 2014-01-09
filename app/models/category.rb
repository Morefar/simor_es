class  Category < ActiveRecord::Base
  default_scope { order(:name) }
  validates :name, presence: true
  validates :name, :uniqueness => true
  validates :name, :length => { :within => (2..20) }
  validates :name, format: { with: /\A[\p{L}\d]+\Z/iu }
end
