class Cosigner < ActiveRecord::Base
  belongs_to :entity
  belongs_to :contract
  validates :entity_id, :contract_id, presence: true
  validates :entity_id, uniqueness: { scope: :contract_id }
  validate :contract_lessee_different_from_cosigner

  delegate :name, to: :entity, prefix: true

  def contract_lessee_different_from_cosigner
    if contract_id && entity_id
      errors.add(:entity_id, "is the lessee of the contract, so it cannot be a cosigner.") if self.contract.lessee_id === self.entity_id
    end
  end
end
