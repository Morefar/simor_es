class Entity < ActiveRecord::Base
  #-- Relationships --------------------
  belongs_to :identification_type
  has_many :leases_on, class_name: "Contract", foreign_key: "lessee_id",
    inverse_of: :lessee, dependent: :restrict_with_error
  has_many :cosigners, dependent: :restrict_with_error
  has_many :contracts, through: :cosigners

  #-- Delegations ----------------------
  delegate :name, to: :identification_type, prefix: true

  #-- Validations ----------------------
  validates :address, :city, :state, :identification_number,
            :identification_type_id, :name, presence: true
  validates :identification_number, uniqueness: { scope: :identification_type_id }
  validates :email, uniqueness: {
                    scope: :identification_type_id,
                    case_sensitive: false
            }, if: "email.present?"
  validates :email, format: { with: /\A[a-zA-Z_.]+@[.a-zA-Z\-_]+\Z/ },
                    if: "email.present?"

  #-- Scopes ---------------------------
  scope :alphabeticaly, -> { order(name: :asc) }
  scope :numericaly, -> { order(identification_number: :asc) }
  scope :by_name, ->(name) { where("name ilike ?", name).alphabeticaly }
  scope :by_id, ->(identification_number) { where("identification_number ilike ?", identification_number).numericaly }
  scope :by_city, ->(city) { where("city ilike ?", city).alphabeticaly }
  scope :by_state, ->(state) { where("state ilike ?", state).alphabeticaly }
  #
  #-- Class Methods --------------------
  def self.search(args = {})
    if args.has_key? :options
      query = parse_query(args)
      send(args[:options].to_s, query)
    else
      all.alphabeticaly
    end
  end

    private
    def self.parse_query(args)
      return "" if args[:query].blank?
      "%#{args[:query]}%"
    end
end
