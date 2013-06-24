class Model < ActiveRecord::Base
  attr_accessible :make_id, :name
  belongs_to :make, inverse_of: :models

  validates :name, presence: true
  validates :name, uniqueness: {scope: :make_id}

end
