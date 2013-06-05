
class Body < ActiveRecord::Base
  attr_accessible :name

  has_many :builds
  has_many :kinds, through: :builds

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /\A([a-zA-Z]\s?)+[a-zA-Z]+\Z/u }
end
