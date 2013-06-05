class IdentificationType < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validates :name, format: { with: /\A[a-zA-Z]+\Z/ }
end
