
class Build < ActiveRecord::Base
  attr_accessible :body_id, :kind_id

  belongs_to :kind
  belongs_to :body

  validates :body_id, :kind_id, presence: true
end
