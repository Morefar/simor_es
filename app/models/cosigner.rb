class Cosigner < ActiveRecord::Base
  attr_accessible :entity_id, :contract_id
  belongs_to :entity
  belongs_to :contract
end
