class Inspection < ActiveRecord::Base
  attr_accessible :address, :city, :state, :date, :current_value, :appraiser_value, :soat_number,  :soat_begin_date, :soat_finish_date, :emissions_certificate, :emissions_begin_date, :emissions_finish_date, :maintenance, :repairs, :security, :exterior, :exterior_notes, :interior, :interior_notes, :engine, :engine_notes, :accesories, :insurance_number, :insurance_company_id, :insured_value, :currency, :insurance_start, :insurance_finish, :person_in_charge, :pic_id, :pic_job, :inspection_number

  belongs_to :asset
  belongs_to :insurance_company
  has_one :contract, through: :asset
  has_one :inventory
  has_many :comments, as: :commentable

  validates :inspection_number, :person_in_charge, :pic_id, :pic_job, :date, :asset,presence: true
  validates :inspection_number, uniqueness: { case_sensitive: false, scope: :asset_id }
  validate :valid_insurance_data
  validate :valid_soat_dates
  validate :valid_emissions_certficate_dates
  after_save :update_parent_asset_information

  def valid_soat_dates
    if soat_number.present?
      if soat_begin_date.present? && soat_finish_date.present?
        errors.add(:soat_finish_date, 'cannot be sooner than the starting date') unless (Date.parse(soat_finish_date) >= (Date.parse(soat_begin_date) >> 12))
      else
        errors.add(:soat_begin_date, 'cannot be empty') unless soat_begin_date.present?
        errors.add(:soat_finish_date, 'cannot be empty') unless soat_finish_date.present?
      end
    else
      errors.add(:soat_begin_date, 'must be empty') if soat_begin_date.present?
      errors.add(:soat_finish_date, 'must be empty') if soat_finish_date.present?
    end
  end

  def valid_insurance_data
    if insurance_number.present?
      if insurance_start.present? && insurance_finish.present?
        errors.add(:insurance_finish, 'cannot be sooner than the starting date') unless (Date.parse(insurance_finish) >= (Date.parse(insurance_start) >> 12))
      else
        errors.add(:insurance_start, 'cannot be empty') unless insurance_start.present?
        errors.add(:insurance_finish, 'cannot be empty') unless insurance_finish.present?
      end
    else
      errors.add(:insurance_start, 'must be empty') if insurance_start.present?
      errors.add(:insurance_finish, 'must be empty') if insurance_finish.present?
    end
  end

  def valid_emissions_certficate_dates
    if emissions_certificate.present?
      if emissions_begin_date.present? && emissions_finish_date.present?
        errors.add(:emissions_finish_date, 'cannot be sooner than the starting date') unless (Date.parse(emissions_finish_date) >= (Date.parse(emissions_begin_date) >> 12))
      else
        errors.add(:emissions_begin_date, 'cannot be empty') unless emissions_begin_date.present?
        errors.add(:emissions_finish_date, 'cannot be empty') unless emissions_finish_date.present?
      end
    else
      errors.add(:emissions_begin_date, 'must be empty') if emissions_begin_date.present?
      errors.add(:emissions_finish_date, 'must be empty') if emissions_finish_date.present?
    end
  end

  def update_parent_asset_information
    if self.asset.present?
      parent_asset = self.asset
      parent_asset.inspection_count += 1
      parent_asset.last_inspection_date = self.updated_at
      parent_asset.save
    end
  end

end
