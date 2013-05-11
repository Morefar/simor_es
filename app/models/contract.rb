class Contract < ActiveRecord::Base
  belongs_to :category
  has_many :assets, inverse_of: :contract
  #has_many :inspections, :through => :assets

  attr_accessible :number, :start_date, :first_canon_date,
            :expiration_date, :duration, :periodicity,
            :total_value, :currency, :asset_count, :location_of_assets,
            :option_to_buy, :last_date_to_option, :category, :client_id
  validates :category, :start_date, :duration, :total_value,
            :expiration_date, :location_of_assets,
            :first_canon_date, :presence => true
  validates :number, :uniqueness => { :case_sensitive => false, scope: :client_id }
  validates :duration, :numericality => { :only_integer => true,
                                          :greater_than => 0 }
  validate :total_value, :numericality => { :greater_than => 0 }
  validate :non_valid_start_date
  validate :non_valid_expiration_date
  validate :non_valid_first_canon_date
  # validate :valid_dates

  def non_valid_start_date
    if !self.start_date.blank? && !self.expiration_date.blank?
      self.errors.add(:start_date, 'must be less than the expiration date') unless (self.start_date < self.expiration_date)
    end
  end

  def non_valid_expiration_date
    if !expiration_date.blank?
      errors.add(:expiration_date, "can't be in the past") if expiration_date < Date.today
      errors.add(:expiration_date, "can't be less that the duration of the contract") if (expiration_date <= (start_date >> (duration*periodicity)))
    end
  end

  def non_valid_first_canon_date
    if !first_canon_date.blank?
      errors.add(:first_canon_date, "can't be earlier than the contract's start date") if start_date > first_canon_date
    end
  end

  def non_valid_last_date_to_option
    if !last_date_to_option.blank? && option_to_buy
      errors.add(:last_date_to_option, "can't be later than the expiration date") unless last_date_to_option > expiration_date
    elsif !option_to_buy
      errors.add(:last_date_to_option, "can't exist because there is no option to buy")
    end
  end
end
