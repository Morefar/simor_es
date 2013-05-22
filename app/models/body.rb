
class Body < ActiveRecord::Base
  attr_accessible :name

  has_many :builds
  has_many :kinds, through: :builds

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, format: {with: /\A(\w+\s*)+\w+\Z/}
end
