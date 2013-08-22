class Contract < ActiveRecord::Base

  attr_accessible :number, :start_date, :first_canon_date, :expiration_date, :duration, :periodicity, :total_value, :currency, :asset_count, :location_of_assets, :client_id, :category_id, :option_to_buy, :last_date_to_option, :category, :client_id, :lessee_id, :lessee, :documents_attributes
  belongs_to :category
  belongs_to :lessee, class_name: 'Entity', foreign_key:'lessee_id'
  has_many :assets, inverse_of: :contract
  has_many :inspections, through: :assets
  has_many :cosigners, inverse_of: :contract
  has_many :entities, through: :cosigners
  has_many :comments, as: :commentable
  has_many :documents, as: :documentable
  accepts_nested_attributes_for :documents, allow_destroy: true

  validates :client_id, :number, :category, :start_date, :duration, :total_value, :lessee, :expiration_date, :location_of_assets, :periodicity, :first_canon_date, presence: true
  validates :number, :uniqueness => { case_sensitive: false, scope: :client_id }
  validates :duration, :numericality => { only_integer: true,
                                          greater_than: 0 }
  validates :total_value, :numericality => { greater_than: 0 }
  validate :non_valid_start_date
  validate :non_valid_expiration_date
  validate :non_valid_first_canon_date
  validate :option_to_buy_validations
  validate :non_valid_option_to_buy_date

  scope :search_number, ->(number) { where("number like ?", number) }

  def non_valid_start_date
    if !self.start_date.blank? && !self.expiration_date.blank?
      self.errors.add(:start_date, 'must be less than the expiration date') unless (self.start_date < self.expiration_date)
    end
  end

  def non_valid_expiration_date
    if !expiration_date.blank?
      errors.add(:expiration_date, "can't be in the past") if expiration_date < Date.today
      errors.add(:expiration_date, "can't be earlier that the duration of the contract. Starting from the first canon payment.") if (expiration_date < (first_canon_date >> (duration*periodicity)))
    end
  end

  def non_valid_first_canon_date
    if !first_canon_date.blank?
      errors.add(:first_canon_date, "can't be earlier than the contract's start date") if start_date > first_canon_date
    end
  end

  def option_to_buy_validations
    errors.add(:last_date_to_option, "can't have a date to excercise option to buy") if ( !option_to_buy && last_date_to_option.present?)
    errors.add(:last_date_to_option, "can't be empty") if (option_to_buy && !last_date_to_option.present?)
  end

  def non_valid_option_to_buy_date
    if option_to_buy && last_date_to_option
      errors.add(:last_date_to_option, "can't be earlier than the expiration date") if (last_date_to_option < expiration_date)
    end
  end
end
