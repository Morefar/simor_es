class Cosigner < ActiveRecord::Base
  attr_accessible :entity_id, :contract_id
  belongs_to :entity
  belongs_to :contract
  validates :entity_id, :contract_id, presence: true
  validates :entity_id, uniqueness: { scope: :contract_id }
end
