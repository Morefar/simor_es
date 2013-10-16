#encoding: UTF-8
class Asset < ActiveRecord::Base
  attr_accessible :invoice_id, :inventory_number, :license_plate, :make_name,
    :model_name, :year, :cylinder_cap, :color_name, :service_type, :kind_name,
    :body_name, :fuel_type, :capacity, :motor_number, :rerecorded_motor, :vin,
    :serial_number, :rerecorded_serial, :chassis_number, :rerecorded_chassis,
    :mobility_restriction, :shield_level, :horse_power, :importd_assembld,
    :import_statement, :color_id, :import_date, :number_of_doors, :property_limitation,
    :registration_date, :tp_issue_date, :tp_expiration_date, :transit_authority,
    :book_value, :last_inspection_date, :contract_number, :transit_permit, :color,
    :make, :model, :body, :kind, :contract

  belongs_to :contract, inverse_of: :assets
  belongs_to :make
  belongs_to :model
  belongs_to :kind
  belongs_to :body
  belongs_to :color
  has_many :inspections
  has_many :comments, as: :commentable
  has_many :documents, as: :documentable

  validates :contract_number, :inventory_number, :license_plate, :make_name,
    :model_name, :year, :registration_date, :tp_issue_date, :transit_authority,
    :book_value, :transit_permit, :color_name, :kind_name, :body_name,
    :chassis_number, presence: true
  validates :transit_permit, length: { is: 11 }
  validates :license_plate, format: {
    with: /\A[a-z]{2}[a-z0-9]\d{3}\Z/i,
    message: 'incorrect format. Try (AAA000)'
  }
  validates :license_plate, length: { is: 6 }
  validates :year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 2000,
    less_than_or_equal_to: (Date.current >> 12).year
  }
  validates :cylinder_cap, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 50,
    less_than_or_equal_to: 8000
  }
  validates :capacity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 2,
    less_than_or_equal_to: 3500
  }
  validates :chassis_number, length: { is: 17 }
  validates :vin, length: { is: 17 }, if: "vin.present?"
  validates :vin, format: {
    with: /\A[^_iIoOqQ\W]+\Z/,
    message: I18n.t('errors.messages.invalid_vin')
  }, if: "vin.present?"
  validates :motor_number, length: { in: 1..17 }, if: "motor_number.present?"
  validates :motor_number, uniqueness: true, if: "motor_number.present?"
  validates :serial_number, length: { in: 1..17 }, if: "serial_number.present?"
  validates :serial_number, uniqueness: true, if: "serial_number.present?"
  validates  :chassis_number, :vin, uniqueness: true
  validates :book_value, numericality: { greater_than: 0 }
  validate :authorized_build
  validate :model_belongs_to_make
  after_create :increase_asset_count_on_contract
  around_destroy :decrease_asset_count_on_contract

  default_scope order("created_at DESC")
  scope :search_license_plate, ->(license_plate) { where("license_plate like ?", license_plate) }

  def authorized_build
    errors.add(:kind, I18n.t('errors.messages.unauthorized_build')) unless Build.authorized_build?(kind_id, body_id)
  end

  def model_belongs_to_make
    errors.add(:model, I18n.t('errors.messages.model_dont_belong_make')) unless make.id == model.make.id
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

  def contract_number
    contract.try(:number)
  end
  def contract_number=(contract_number)
    self.contract = Contract.find_by_number(contract_number) if contract_number.present?
  end

  def make_name
    make.try(:name)
  end
  def make_name=(make_name)
    self.make = Make.find_by_name(make_name) if make_name.present?
  end

  def model_name
    model.try(:name)
  end
  def model_name=(model_name)
    self.model = Model.find_by_name(model_name) if model_name.present?
  end

  def color_name
    color.try(:name)
  end
  def color_name=(color_name)
    self.color = Color.find_by_name(color_name) if color_name.present?
  end

  def kind_name
    kind.try(:name)
  end
  def kind_name=(kind_name)
    self.kind = Kind.find_by_name(kind_name) if kind_name.present?
  end

  def body_name
    body.try(:name)
  end
  def body_name=(body_name)
    self.body = Body.find_by_name(body_name) if body_name.present?
  end
end
