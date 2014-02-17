# ## Schema Information
#
# Table name: `cosigners`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`entity_id`**    | `integer`          |
# **`contract_id`**  | `integer`          |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#

class Cosigner < ActiveRecord::Base
  belongs_to :entity
  belongs_to :contract
  validates :entity_id, presence: true
  validates :entity_id, uniqueness: { scope: :contract_id }
  validate :contract_lessee_different_from_cosigner

  delegate :name, to: :entity, prefix: true, allow_nil: true

  def contract_lessee_different_from_cosigner
    if contract_id && entity_id
      error_message = %{ es el arrendatario del contrato, por lo tanto no
      puede ser codeudor del mismo contrato. }
      if self.contract.lessee_id === self.entity_id
        errors.add(:entity_name, error_message)
      end
    end
  end

  def entity_name=(entity_name)
    if entity_name.present?
      self.entity = Entity.find_by_name(entity_name)
    end
  end
end
