#encoding: UTF-8
class Asset < ActiveRecord::Base
  attr_accessible :contract_id, :invoice_id,:inventory_number,:license_plate,
    :make_id,:model_id, :year, :cylinder_cap,:color,:service_type,:kind_id,:body_id,
    :fuel_type, :capacity,:motor_number, :rerecorded_motor,:vin,:serial_number,
    :rerecorded_serial,:chassis_number, :rerecorded_chassis,:mobility_restriction,
    :shield_level,:horse_power, :importd_assembld,:import_statement, :color_id,
    :import_date, :number_of_doors,:property_limitation,:registration_date,
    :tp_issue_date,:tp_expiration_date,:transit_authority,:book_value, :asset_count, :last_inspection_date

  belongs_to :contract, inverse_of: :assets
  # belongs_to :invoice, inverse_of: :assets
  belongs_to :make
  belongs_to :model
  belongs_to :kind
  belongs_to :body
  belongs_to :color
  has_many :inspections
  has_many :comments, as: :commentable

  validates :inventory_number, :license_plate, :make, :model, :year, :registration_date,
    :tp_issue_date, :tp_expiration_date, :transit_authority, :book_value, presence: true
  validates :license_plate, :length => { is: 6 }
  validates :license_plate, :format => { with: /\A[a-z]{2}[a-z0-9]\d{3}\Z/i,
    message: 'incorrect format. Try (AAA000)'
  }
  validates :year, :numericality => {
    only_integer: true,
    greater_than_or_equal_to: 2000,
    less_than_or_equal_to: (Date.current >> 12).year
  }
  validates :cylinder_cap, :numericality => {
    only_integer: true,
    greater_than_or_equal_to: 50,
    less_than_or_equal_to: 8000
  }
  validates :capacity, :numericality => {
    only_integer: true,
    greater_than_or_equal_to: 2,
    less_than_or_equal_to: 3500
  }
  validates :serial_number, :motor_number, :chassis_number, :vin, :length => { is: 17 }
  # validates :serial_number, :motor_number, :chassis_number,  :vin, uniqueness: true
  validates :vin, :format => { with: /\A[^_iIoOqQ\W]+\Z/,
    message: "has an incorrect format. 'I', 'O', 'Q', 'Ñ' or non-word characters are not allowed."
  }
  validate :authorized_build

  def authorized_build
    errors.add(:kind, 'The build combination isn\'t authorized') unless Build.authorized_build?(kind_id, body_id)
  end

  def unique_identifier_present

  end
end
