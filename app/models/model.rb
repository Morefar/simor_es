class Model < ActiveRecord::Base
  attr_accessible :make_id, :name
  belongs_to :make, inverse_of: :models
  delegate :name, to: :make, prefix: true
  default_scope order(:make_id, :name)
  scope :search_name, ->(name) { where("name ilike ?", name) }
  validates :name, presence: true
  validates :name, uniqueness: { scope: :make_id }
end
