class Make < ActiveRecord::Base
  attr_accessible :name
  has_many :models, inverse_of: :make

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :search_name, ->(name) { where("name ilike ?", name) }
end
