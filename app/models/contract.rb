class Contract < ActiveRecord::Base

  attr_accessible :number, :start_date, :first_canon_date, :expiration_date, :duration, :periodicity, :total_value, :currency, :asset_count, :location_of_assets, :client_id, :category_id, :option_to_buy, :last_date_to_option, :category, :client_id, :lessee_id, :lessee, :documents_attributes, :cosigners_attributes, :entity_name
  belongs_to :category
  belongs_to :lessee, class_name: 'Entity', foreign_key:'lessee_id'
  has_many :assets, inverse_of: :contract
  has_many :inspections, through: :assets
  has_many :cosigners, inverse_of: :contract
  has_many :entities, through: :cosigners
  has_many :comments, as: :commentable
  has_many :documents, as: :documentable
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :cosigners

  validates :client_id, :number, :category, :start_date, :duration, :total_value, :lessee, :expiration_date, :location_of_assets, :periodicity, :first_canon_date, presence: true
  validates :number, :uniqueness => { case_sensitive: false, scope: :client_id }
  validates :duration, :numericality => { only_integer: true,
                                          greater_than: 0 }
  validates :total_value, :numericality => { greater_than: 0 }
  validates :last_date_to_option, presence: true, if: "option_to_buy?"
  validate :non_valid_expiration_date
  validate :non_valid_first_canon_date
  validate :non_valid_option_to_buy_date

  scope :search_number, ->(number) { where("number like ?", number) }

  def lessee_name=(lessee_name)
      self.lesse = Entity.find_by_name(lessee_name) if lessee_name.present?
  end
  def lessee_name
    lessee.try(:name)
  end

  def non_valid_expiration_date
    if expiration_date?
      errors.add(:expiration_date, I18n.t("errors.messages.expiration_in_past")) if expiration_date < Date.today
      errors.add(:expiration_date, I18n.t("errors.messages.expiration_shorter_than_contract")) if (expiration_date < (first_canon_date >> (duration*periodicity)))
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
end
