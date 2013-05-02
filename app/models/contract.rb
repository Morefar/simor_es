class Contract < ActiveRecord::Base
  belongs_to :category
  has_many :assets, inverse_of: :contract
  # validates_asociated :assets
  #has_many :inspections, :through => :assets
  validates_presence_of :category, :start_date, :month_duration, :total_value, :expiration_date,:asset_count, :location_of_assets
  # validates :number, :uniqueness => true
  validates :total_value, :numericality => {:greater_than => 0}
  # validate :non_valid_expiration_date


  def non_valid_expiration_date
    if !expiration_date.blank?
      errors.add(:expiration_date, "can't be in the past") if expiration_date < Date.today
      errors.add(:expiration_date, "can't be less that the duration of the contract") if (expiration_date <= (start_date << month_duration))
    end
  end
end
