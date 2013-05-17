class Color < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, format: {with: /\A(\w+\s)+\w+\Z/}
end
