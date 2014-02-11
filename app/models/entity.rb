class Entity < ActiveRecord::Base

  belongs_to :identification_type
  has_many :cosigners
  has_many :contracts, through: :cosigners

  delegate :name, to: :identification_type, prefix: true
  validates :address, :city, :state, :identification_number,
            :identification_type_id, :name, presence: true
  validates :identification_number, uniqueness: { scope: :identification_type_id }
  validates :email, uniqueness: {
                    scope: :identification_type_id,
                    case_sensitive: false
            }, if: "email.present?"
  validates :email, format: { with: /\A[a-zA-Z_.]+@[.a-zA-Z\-_]+\Z/ },
                    if: "email.present?"

  scope :search_name, ->(term) { where("name ilike ?", term) }

  def contracts_as_lessee
    Array( Contract.where(lessee_id: id).order("created_at DESC"))
  end

  def contracts_as_lessee_count
    Contract.where(lessee_id: id).count
  end

  def contracts_as_cosigner
    contracts.order("created_at DESC")
  end

  def contracts_as_cosigner_count
    contracts.count
  end
end
