class Asset < ActiveRecord::Base
  belongs_to :contract, inverse_of: :assets
  attr_accessible :contract_id, :invoice_id, :inventory_number, :license_plate,
                :chassis_number, :motor_number, :horse_power, :capacity,
                :capacity_unit, :make, :model, :year, :color, :build, :service_type,
                :service_mode, :fuel_type, :book_value

end
