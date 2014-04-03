# ## Schema Information
#
# Table name: `inspections`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`id`**                     | `integer`          | `not null, primary key`
# **`inspection_number`**      | `string(255)`      |
# **`asset_id`**               | `integer`          |
# **`address`**                | `string(255)`      |
# **`city`**                   | `string(255)`      |
# **`state`**                  | `string(255)`      |
# **`current_value`**          | `float`            |
# **`appraiser_value`**        | `integer`          |
# **`soat_number`**            | `string(255)`      |
# **`soat_begin_date`**        | `string(255)`      |
# **`soat_finish_date`**       | `string(255)`      |
# **`emissions_certificate`**  | `string(255)`      |
# **`emissions_begin_date`**   | `string(255)`      |
# **`emissions_finish_date`**  | `string(255)`      |
# **`exterior`**               | `string(255)`      |
# **`exterior_notes`**         | `text`             |
# **`interior`**               | `string(255)`      |
# **`interior_notes`**         | `text`             |
# **`engine`**                 | `string(255)`      |
# **`engine_notes`**           | `text`             |
# **`accesories`**             | `text`             |
# **`insurance_number`**       | `string(255)`      |
# **`insurance_company_id`**   | `integer`          |
# **`insured_value`**          | `integer`          |
# **`currency`**               | `string(255)`      |
# **`insurance_start`**        | `string(255)`      |
# **`insurance_finish`**       | `string(255)`      |
# **`person_in_charge`**       | `string(255)`      |
# **`pic_id`**                 | `string(255)`      |
# **`pic_job`**                | `string(255)`      |
# **`created_at`**             | `datetime`         | `not null`
# **`updated_at`**             | `datetime`         | `not null`
# **`observations`**           | `text`             |
# **`modifications`**          | `boolean`          | `default(FALSE)`
# **`odometer`**               | `string(255)`      | `default("0")`
# **`inspection_date`**        | `datetime`         |
# **`maintenance`**            | `boolean`          | `default(TRUE)`
# **`repairs`**                | `boolean`          | `default(TRUE)`
# **`security`**               | `boolean`          | `default(TRUE)`
# **`inspection_order_id`**    | `integer`          |
# **`overall_condition`**      | `string(255)`      |
#

class Inspection < ActiveRecord::Base
  #-- Relationships --------------------
  belongs_to :asset
  belongs_to :inspection_order, inverse_of: :inspection
  belongs_to :insurance_company
  has_one :contract, through: :asset
  has_one :inventory, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :restrict_with_error

  #-- Delegations ----------------------
  delegate :book_value, :license_plate, :inventory_number, :kind_name,
          :chassis_number, :make_name, :model_name, :year, :service_type,
          :vin, to: :asset, prefix: true, allow_nil: true
  delegate :name, to: :insurance_company, prefix: true, allow_nil: true
  delegate :id, to: :inspection_order, prefix: true, allow_nil: true
  delegate :requester_email, :requester_full_name, :token,
    to: :inspection_order, allow_nil: true

  #-- Validations ----------------------
  validates :inspection_number, :person_in_charge, :pic_id, :pic_job,
    :inspection_date, :asset, :address, :city, :state, :exterior,
    :exterior_notes, :interior, :interior_notes, :engine, :engine_notes,
    :overall_condition, :observations, :inspection_order_id, presence: true
  validates :inspection_number, uniqueness: { case_sensitive: false, scope: :asset_id }, on: :create
  validates :insurance_start, :insurance_finish,
    presence: true, if:  "insurance_number.present?"
  validates :emissions_begin_date, :emissions_finish_date,
    presence: true,if: "emissions_certificate.present?"
  validates :soat_begin_date, :soat_finish_date,
    presence: true, if: "soat_number.present?"
  validate :correct_inspection_order
  validate :valid_insurance_data
  validate :valid_soat_dates
  validate :valid_emissions_certficate_dates

  #-- Callbacks ------------------------
  before_save :clean_unwanted_dates
  after_create :increase_inspection_count_on_asset
  after_create :link_to_order
  before_destroy :revert_order_state
  around_destroy :decrease_inspection_count_on_asset

  #-- Scopes ---------------------------
  scope :by_recency, -> { order("inspection_date DESC") }
  scope :by_number_order, -> { order("inspection_number ASC") }
  scope :by_number, ->(number) { where("inspection_number ilike ?", number) }
  scope :by_date, ->(date) { where(inspection_date: date).by_number_order }
  scope :by_range,
    ->(range) { where(inspection_date: range).by_recency.by_number_order }
  scope :by_asset,
    ->(license_plate) { self.joins(:asset).where("assets.license_plate ilike ?", license_plate) }

  #-- Class Methods --------------------
  def self.search(args = {})
    if args.has_key? :options
      query = parse_query(args)
      send(args[:options].to_s, query)
    else
      all.by_recency
    end
  end

  #-- Instance Methods -----------------
  def asset_license_plate= (license_plate)
    self.asset = Asset.find_by_license_plate(license_plate) if license_plate.present?
  end

  private
  def valid_soat_dates
    if soat_number? && soat_begin_date? && soat_finish_date?
      unless (Date.parse(soat_finish_date) >= (Date.parse(soat_begin_date) >> 11))
        errors.add(:soat_finish_date, I18n.t("errors.messages.earlier_than_start_date"))
      end
    end
  end

  def valid_insurance_data
    if insurance_number? && insurance_start? && insurance_finish?
      unless (Date.parse(insurance_finish) >= (Date.parse(insurance_start) >> 11))
        errors.add(:insurance_finish, I18n.t("errors.messages.earlier_than_start_date"))
      end
    end
  end

  def valid_emissions_certficate_dates
    if emissions_certificate? && emissions_begin_date? && emissions_finish_date?
      unless (Date.parse(emissions_finish_date) >= (Date.parse(emissions_begin_date) >> 11))
        errors.add(:emissions_finish_date, I18n.t("errors.messages.earlier_than_start_date"))
      end
    end
  end

  def correct_inspection_order
    if inspection_order.present?
      unless  inspection_order.asset == asset
        errors.add(:inspection_order_id, "no corresponde al activo indicado.")
      end
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

  def link_to_order
    self.inspection_order.close!
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
  def revert_order_state
    if self.inspection_order.may_revert_inspected?
      self.inspection_order.revert_inspected!
    end
  end
  def self.parse_query(args)
    return "" if args[:query].blank?
    case args[:options].to_s
    when "by_date"
      begin
        Date.strptime(args[:query], '%d/%m/%y')
      rescue
        Time.now
      end
    when "by_range"
      dates = args[:query].split('-')
      begin
        start = Date.strptime(dates[0].strip, '%d/%m/%Y')
        finish = dates[1] ? Date.strptime(dates[1].strip, '%d/%m/%Y') : Date.today
        start..finish
      rescue
        Date.today..Date.today
      end
    else
      "%#{args[:query]}%"
    end
  end
end
