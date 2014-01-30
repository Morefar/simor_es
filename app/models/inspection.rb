class Inspection < ActiveRecord::Base
  belongs_to :asset
  belongs_to :inspection_order
  belongs_to :insurance_company
  has_one :contract, through: :asset
  has_one :inventory
  has_many :comments, as: :commentable
  has_many :documents, as: :documentable
  delegate :book_value, :license_plate, :inventory_number, :kind_name,
          :chassis_number, :make_name, :model_name, :year, :service_type,
          :vin, to: :asset, prefix: true, allow_nil: true
  validates :inspection_number, :person_in_charge, :pic_id, :pic_job, :inspection_date, :asset,presence: true
  validates :inspection_number, uniqueness: { case_sensitive: false, scope: :asset_id }
  validates :insurance_start, :insurance_finish, presence: true, if:  "insurance_number.present?"
  validates :emissions_begin_date, :emissions_finish_date, presence: true,if: "emissions_certificate.present?"
  validates :soat_begin_date, :soat_finish_date, presence: true, if: "soat_number.present?"
  validate :valid_insurance_data
  validate :valid_soat_dates
  validate :valid_emissions_certficate_dates
  before_save :clean_unwanted_dates
  after_create :increase_inspection_count_on_asset
  around_destroy :decrease_inspection_count_on_asset
  default_scope { order("inspection_date DESC") }

  def asset_license_plate= (license_plate)
    self.asset = Asset.find_by_license_plate(license_plate) if license_plate.present?
  end

  private
  def valid_soat_dates
    if soat_number? && soat_begin_date? && soat_finish_date?
      errors.add(:soat_finish_date, I18n.t("errors.messages.earlier_than_start_date")) unless (Date.parse(soat_finish_date) >= (Date.parse(soat_begin_date) >> 12))
    end
  end

  def valid_insurance_data
    if insurance_number? && insurance_start? && insurance_finish?
      errors.add(:insurance_finish, I18n.t("errors.messages.earlier_than_start_date")) unless (Date.parse(insurance_finish) >= (Date.parse(insurance_start) >> 12))
    end
  end

  def valid_emissions_certficate_dates
    if emissions_certificate? && emissions_begin_date? && emissions_finish_date?
      errors.add(:emissions_finish_date, I18n.t("errors.messages.earlier_than_start_date")) unless (Date.parse(emissions_finish_date) >= (Date.parse(emissions_begin_date) >> 12))
    end
  end

  def increase_inspection_count_on_asset
    if self.asset.present?
      parent_asset = self.asset
      parent_asset.inspection_count += 1
      parent_asset.last_inspection_date = self.updated_at
      parent_asset.save
    end
  end

  def decrease_inspection_count_on_asset
    if self.asset.present?
      parent_asset = self.asset
      yield
      parent_asset.inspection_count -= 1
      parent_asset.save
    end
  end

  def clean_unwanted_dates
    clean_insurance_dates
    clean_soat_dates
    clean_emissions_certificate_dates
  end

  def clean_insurance_dates
    unless insurance_number?
     remove_dates(insurance_start, insurance_finish)
    end
  end
  def clean_soat_dates
    unless soat_number?
     remove_dates(soat_begin_date, soat_finish_date)
    end
  end
  def clean_emissions_certificate_dates
    unless emissions_certificate?
      remove_dates(emissions_begin_date, emissions_finish_date)
    end
  end
  def remove_dates(first_date, second_date)
    first_date, second_date = nil, nil
  end

end
