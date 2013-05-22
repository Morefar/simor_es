
class Kind < ActiveRecord::Base
  attr_accessible :name

  has_many :build_restrictions
  has_many :bodies, through: :builds

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, format: {with: /\A(\w+\s*)+\w+\Z/}
end