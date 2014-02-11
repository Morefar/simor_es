class Entity < ActiveRecord::Base
  belongs_to :identification_type
  has_many :leases_on, class_name: "Contract", foreign_key: "lessee_id",
    inverse_of: :lessee, dependent: :restrict_with_error
  has_many :cosigners, dependent: :restrict_with_error
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
end
