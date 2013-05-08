class Asset < ActiveRecord::Base
  belongs_to :contract, inverse_of: :assets
  attr_accessible :contract_id, :invoice_id, :inventory_number, :licence_plate,
                :chassis_number, :motor_number, :cylinder_cap, :capacity,
                :capacity_unit, :make, :model, :year, :color, :build, :service_type,
                :service_mode, :fuel_type, :book_value

end
