class Contract < ActiveRecord::Base
  belongs_to :category
  has_many :assets, inverse_of: :contract
  #has_many :inspections, :through => :assets

  validates :category, :start_date, :duration, :total_value, :expiration_date,:asset_count, :location_of_assets, :first_canon_date, :presence => true
  validates :number, :uniqueness => { :case_sensitive => false }
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
      errors.add(:first_canon_date, "can't be earlier than the contract's start date") unless start_date < first_canon_date
    end
  end

end
