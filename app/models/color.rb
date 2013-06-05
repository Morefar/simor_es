class Color < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /\A([a-zA-Z]\s?)+[a-zA-Z]+\Z/u }
end
