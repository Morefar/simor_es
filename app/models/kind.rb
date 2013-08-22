
class Kind < ActiveRecord::Base
  attr_accessible :name

  has_many :builds
  has_many :bodies, through: :builds

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, format: { with: /\A([a-zA-Z]\s?)+[a-zA-Z]+\Z/u }
  scope :search_name, ->(name) { where("name ilike ?", name) }
end
