class Inspection < ActiveRecord::Base
  attr_accessible :address, :city, :state, :date, :current_value, :appraiser_value, :soat_number,  :soat_begin_date, :soat_finish_date, :emissions_certificate, :emissions_begin_date, :emissions_finish_date, :maintenance, :repairs, :security, :exterior, :exterior_notes, :interior, :interior_notes, :engine, :engine_notes, :accesories, :insurance_number, :insurance_company_id, :insured_value, :currency, :insurance_start, :insurance_finish, :person_in_charge, :pic_id, :pic_job, :inspection_number, :asset_id

  belongs_to :asset
  belongs_to :insurance_company
  has_one :contract, through: :asset
  has_one :inventory
  has_many :comments, as: :commentable
  has_many :documents, as: :documentable

  validates :inspection_number, :person_in_charge, :pic_id, :pic_job, :date, :asset,presence: true
  validates :inspection_number, uniqueness: { case_sensitive: false, scope: :asset_id }
  validates :insurance_start, :insurance_finish, presence: true, if:  "insurance_number.present?"
  validates :emissions_begin_date, :emissions_finish_date, presence: true,if: "emissions_certificate.present?"
  validates :soat_begin_date, :soat_finish_date, presence: true, if: "soat_number.present?"
  validate :valid_insurance_data
  validate :valid_soat_dates
  validate :valid_emissions_certficate_dates
  before_save :clean_unwanted_dates
  after_save :update_parent_asset_information

  private
  def valid_soat_dates
    if soat_number.present? && soat_begin_date.present? && soat_finish_date.present?
      errors.add(:soat_finish_date, 'cannot be sooner than the starting date') unless (Date.parse(soat_finish_date) >= (Date.parse(soat_begin_date) >> 12))
    end
  end

  def valid_insurance_data
    if insurance_number.present? && insurance_start.present? && insurance_finish.present?
      errors.add(:insurance_finish, 'cannot be sooner than the starting date') unless (Date.parse(insurance_finish) >= (Date.parse(insurance_start) >> 12))
    end
  end

  def valid_emissions_certficate_dates
    if emissions_certificate.present? && emissions_begin_date.present? && emissions_finish_date.present?
      errors.add(:emissions_finish_date, 'cannot be sooner than the starting date') unless (Date.parse(emissions_finish_date) >= (Date.parse(emissions_begin_date) >> 12))
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

  def clean_unwanted_dates
    clean_insurance_dates
    clean_soat_dates
    clean_emissions_certificate_dates
  end

  def clean_insurance_dates
    unless insurance_number.present?
     remove_dates(insurance_start, insurance_finish)
    end
  end
  def clean_soat_dates
    unless soat_number.present?
     remove_dates(soat_begin_date, soat_finish_date)
    end
  end
  def clean_emissions_certificate_dates
    unless emissions_certificate.present?
      remove_dates(emissions_begin_date, emissions_finish_date)
    end
  end
  def remove_dates(first_date, second_date)
    first_date, second_date = nil, nil
  end

end
