class Contract < ActiveRecord::Base
  include PgSearch
  # attr_accessible :number, :start_date, :first_canon_date, :expiration_date,
  # :duration, :periodicity, :total_value, :currency, :asset_count,
  # :location_of_assets, :client_id, :category_id, :option_to_buy,
  # :last_date_to_option, :category, :client_id, :lessee_id, :lessee_name,
  # :lessee, :documents_attributes, :cosigners_attributes, :entity_name

  # -- Relationships -------------------
  belongs_to :category
  belongs_to :lessee, class_name: 'Entity', foreign_key:'lessee_id',
    inverse_of: :leases_on
  has_many :assets, inverse_of: :contract, dependent: :restrict_with_error
  has_many :inspections, through: :assets
  has_many :cosigners, inverse_of: :contract, validate: true
  has_many :entities, through: :cosigners
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :restrict_with_error
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :cosigners, allow_destroy: true

  # -- Delegations ---------------------
  delegate :name, :identification_number, :identification_type_name,
           to: :lessee, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  # -- Validations ---------------------
  validates :number, :category, :start_date, :duration,
    :total_value, :lessee, :expiration_date, :location_of_assets, :periodicity,
    :first_canon_date, presence: true
  validates :number, :uniqueness => { case_sensitive: false }
  validates :duration, :numericality => { only_integer: true,
                                          greater_than: 0 }
  validates :total_value, :numericality => { greater_than: 0 }
  validates :last_date_to_option, presence: true, if: "option_to_buy?"
  validate :non_valid_expiration_date
  validate :non_valid_first_canon_date
  validate :non_valid_option_to_buy_date

  # -- Scopes --------------------------
  scope :ordered_by_creation, -> { order("created_at DESC") }
  scope :search_by_number, ->(number) { where("number like ?", number) }
  scope :search_by_date, ->date { where( %{
        start_date = :date OR first_canon_date = :date OR
        expiration_date = :date OR created_at = :date }, date: date) }
  scope :search_by_range, ->dates { where( %{
        start_date BETWEEN :start AND :end OR
        expiration_date BETWEEN :start AND :end OR
        created_at BETWEEN :start AND :end },
        start: dates[:start], end: dates[:end]) }
  pg_search_scope :search_by_lessee, associated_against: {
    lessee: [:identification_number, :name],
    entities: [:identification_number, :name] },
    using: { tsearch: { dictionary: "spanish", prefix: true, any_word: true } }

  # -- Class Methods -------------------
  def self.contract_search(args={})
    query = parse_search_query(args)
    if args.has_key? :query_options
      send("search_#{args[:query_options]}", query)
    elsif args.has_key? :contract_query
      search_by_lessee(query).ordered_by_creation
    else
      all.ordered_by_creation
    end
  end

  # -- Instance Methods ----------------
  def lessee_name=(lessee_name)
      self.lessee = Entity.find_by_name(lessee_name) if lessee_name.present?
  end

  def lessee_name
    lessee.try(:name)
  end

  private
  def non_valid_expiration_date
    if expiration_date?
      errors.add(:expiration_date, I18n.t("errors.messages.expiration_in_past")) if expiration_date < Date.today
      errors.add(:expiration_date, I18n.t("errors.messages.expiration_shorter_than_contract")) if (expiration_date < (first_canon_date >> ((duration-1)*periodicity)))
    end
  end

  def non_valid_first_canon_date
    if first_canon_date?
      errors.add(:first_canon_date, I18n.t("errors.messages.earlier_than_start_date")) if (start_date > first_canon_date)
    end
  end

  def non_valid_option_to_buy_date
    if option_to_buy && last_date_to_option
      errors.add(:last_date_to_option, I18n.t("errors.messages.later_than_expiration_date")) if (last_date_to_option > expiration_date)
    end
  end

  def self.parse_search_query(args = {})
    case args.fetch(:query_options) { "by_number" }
    when "by_number"
      query = "%#{args[:contract_query]}%"
    when "by_date"
      begin
        query = Date.strptime args[ :contract_query ], '%d/%m/%Y'
      rescue ArgumentError
        query = Date.today
      end
    when "by_range"
      dates = args[:contract_query].split('-')
      query = {}
      begin
        query[:start] = Date.strptime(dates[0].strip, '%d/%m/%Y')
        query[:end] = dates[1] ? Date.strptime(dates[1].strip, '%d/%m/%Y') : Date.today
      rescue ArgumentError
        query[:start] = Date.today
        query[:end] = Date.today
      end
    else
      query = args[:contract_query]
    end
    query
  end
end
