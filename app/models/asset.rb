#encoding: UTF-8
# ## Schema Information
#
# Table name: `assets`
#
# ### Columns
#
# Name                        | Type               | Attributes
# --------------------------- | ------------------ | ---------------------------
# **`id`**                    | `integer`          | `not null, primary key`
# **`contract_id`**           | `integer`          |
# **`invoice_id`**            | `integer`          |
# **`inventory_number`**      | `string(255)`      |
# **`transit_permit`**        | `string(255)`      |
# **`license_plate`**         | `string(255)`      |
# **`make_id`**               | `integer`          |
# **`model_id`**              | `integer`          |
# **`year`**                  | `integer`          |
# **`cylinder_cap`**          | `integer`          |
# **`color_id`**              | `integer`          |
# **`service_type`**          | `string(255)`      |
# **`kind_id`**               | `integer`          |
# **`body_id`**               | `integer`          |
# **`fuel_type`**             | `string(255)`      |
# **`capacity`**              | `integer`          |
# **`motor_number`**          | `string(255)`      |
# **`rerecorded_motor`**      | `boolean`          |
# **`vin`**                   | `string(255)`      |
# **`serial_number`**         | `string(255)`      |
# **`rerecorded_serial`**     | `boolean`          |
# **`chassis_number`**        | `string(255)`      |
# **`rerecorded_chassis`**    | `boolean`          |
# **`mobility_restriction`**  | `string(255)`      |
# **`shield_level`**          | `integer`          |
# **`horse_power`**           | `string(255)`      |
# **`importd_assembld`**      | `boolean`          |
# **`import_statement`**      | `string(255)`      |
# **`import_date`**           | `string(255)`      |
# **`number_of_doors`**       | `integer`          |
# **`property_limitation`**   | `string(255)`      |
# **`registration_date`**     | `string(255)`      |
# **`tp_issue_date`**         | `string(255)`      |
# **`tp_expiration_date`**    | `string(255)`      |
# **`transit_authority`**     | `string(255)`      |
# **`book_value`**            | `float`            |
# **`inspection_count`**      | `integer`          | `default(0)`
# **`last_inspection_date`**  | `date`             |
# **`created_at`**            | `datetime`         | `not null`
# **`updated_at`**            | `datetime`         | `not null`
#

class Asset < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }

  #-- Relationships --------------------
  belongs_to :contract, inverse_of: :assets
  belongs_to :make
  belongs_to :model
  belongs_to :kind
  belongs_to :body
  belongs_to :color
  has_many :inspections, inverse_of: :asset, dependent: :restrict_with_error
  has_many :inspection_orders
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :restrict_with_error

  #-- Delegations ----------------------
  delegate :number, to: :contract, prefix: true, allow_nil: true
  delegate :name, to: :make, prefix: true, allow_nil: true
  delegate :name, to: :model, prefix: true, allow_nil: true
  delegate :name, to: :color, prefix: true, allow_nil: true
  delegate :name, to: :kind, prefix: true, allow_nil: true
  delegate :name, to: :body, prefix: true, allow_nil: true

  # -- Validations ---------------------
  validates :inventory_number, :license_plate, :make_name, :model_name, :year,
    :color_name, :kind_name, :chassis_number, presence: true, on: :create
  validates :contract_number, :inventory_number, :license_plate, :make_name,
    :model_name, :year, :registration_date, :tp_issue_date, :transit_authority,
    :book_value, :transit_permit, :color_name, :kind_name, :body_name,
    :chassis_number, presence: true, on: :update
  validates :transit_permit, length: { is: 11 }, if: "transit_permit.present?"
  validates :license_plate, format: { with: /\A[a-z]{2}[a-z0-9]\d{3}\Z/i,
                            message: 'incorrect format. Try (AAA000)' }
  validates :license_plate, length: { is: 6 }
  validates :license_plate, uniqueness: true
  validates :year, numericality: { only_integer: true,
    greater_than_or_equal_to: 2000,
    less_than_or_equal_to: (Date.current >> 12).year }
  validates :cylinder_cap, numericality: {
    only_integer: true, greater_than_or_equal_to: 50,
    less_than_or_equal_to: 8000 }, if: "cylinder_cap.present?"
  validates :capacity, numericality: {
    only_integer: true, greater_than_or_equal_to: 2,
    less_than_or_equal_to: 3500 }, if: "capacity.present?"
  validates :chassis_number, length: { is: 17 }
  validates :vin, length: { is: 17 }, if: "vin.present?"
  validates :vin, format: {
    with: /\A[^_iIoOqQ\W]+\Z/, message: I18n.t('errors.messages.invalid_vin')
  }, if: "vin.present?"
  validates :motor_number, length: { in: 1..17 }, if: "motor_number.present?"
  validates :motor_number, uniqueness: true, if: "motor_number.present?"
  validates :serial_number, length: { in: 1..17 }, if: "serial_number.present?"
  validates :serial_number, uniqueness: true, if: "serial_number.present?"
  validates :chassis_number, uniqueness: true
  validates :vin, uniqueness: true, if: "vin.present?"
  validates :book_value, numericality: { greater_than: 0 }
  validate :model_belongs_to_make

  #-- Callbacks ------------------------
  after_create :increase_asset_count_on_contract
  around_destroy :decrease_asset_count_on_contract

  #-- Scopes ---------------------------
  scope :by_recency, -> { order("created_at DESC") }
  scope :by_make,
    ->(make_name) { self.joins(:make).where("makes.name ilike ?", make_name).
                    order("makes.name ASC") }
  scope :by_model,
    ->(model_name) { self.joins(:model).
                     where("models.name ilike ?", model_name).
                     order("models.name ASC") }
  scope :by_license_plate,
    ->(license_plate) { where("license_plate ilike ?", license_plate).
                        order("license_plate ASC") }
  scope :by_year,
    ->(year) { where("year = ?", year).by_recency }

  #-- Class Methods --------------------
  def self.search(args = {})
    if args.has_key? :options
      query = parse_query(args)
      send(args[:options].to_s, query)
    else
      all.by_recency
    end
  end

  def self.policy_class
    AssetPolicy
  end

  #-- Instance Methods -----------------
  def contract_number=(contract_number)
    if contract_number.present?
      self.contract = Contract.find_by_number(contract_number)
    end
  end

  def make_name=(make_name)
    if make_name.present?
      self.make = Make.find_by_name(make_name)
    end
  end

  def model_name=(model_name)
    if model_name.present? && make.present?
      model_found = Model.where(name: model_name, make: self.make).first
      if model_found
        self.model = model_found
      else
        self.model = Model.where(name: model_name).first
      end
    end
  end

  def color_name=(color_name)
    if color_name.present?
      self.color = Color.find_by_name(color_name)
    end
  end

  def kind_name=(kind_name)
    if kind_name.present?
      self.kind = Kind.find_by_name(kind_name)
    end
  end

  def body_name=(body_name)
    if body_name.present?
      self.body = Body.find_by_name(body_name)
    end
  end

  private
  def self.parse_query(args)
    return "" if args[:query].blank?
    if args[:options].to_s.eql?("by_year")
      args[:query]
    else
      "%#{args[:query]}%"
    end
  end

  def model_belongs_to_make
    if make.present? && model.present?
      unless make.id == model.make_id
        errors.add(:model_name, I18n.t('errors.messages.model_dont_belong_make'))
      end
    end
  end

  def increase_asset_count_on_contract
    if self.contract.present?
      parent_contract = self.contract
      parent_contract.asset_count += 1
      parent_contract.save
    end
  end

  def decrease_asset_count_on_contract
    if self.contract.present?
      parent_contract = self.contract
      yield
      parent_contract.asset_count -= 1
      parent_contract.save
    end
  end
end
