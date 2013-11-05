class Model < ActiveRecord::Base
  attr_accessible :make_id, :name
  belongs_to :make, inverse_of: :models
  delegate :name, to: :make, prefix: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :make_id }

  scope :search_name, ->(name) { where("name ilike ?", name) }
end
