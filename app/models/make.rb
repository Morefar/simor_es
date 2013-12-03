class Make < ActiveRecord::Base
  attr_accessible :name, :runt_code
  has_many :models, inverse_of: :make

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, format: { with: /\A[\p{L}\p{P}\+\d\s]+\Z/iu }
  default_scope order(:name)
  scope :search_name, ->(name) { where("name ilike ?", name) }
end
