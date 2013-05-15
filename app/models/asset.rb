class Asset < ActiveRecord::Base
  belongs_to :contract, inverse_of: :assets
  attr_accessible :contract_id, :invoice_id,:inventory_number,:license_plate,
    :make,:model, :year, :cylinder_cap,:color,:service_type,:kind,:body,
    :fuel_type, :capacity,:motor_number, :rerecorded_motor,:vin,:serial_number,
    :rerecorded_serial,:chassis_number, :rerecorded_chassis,:mobility_restriction,
    :shield_level,:horse_power, :importd_assembld,:import_statement,
    :import_date, :number_of_doors,:property_limitation,:registration_date,
    :tp_issue_date,:tp_expiration_date,:transit_authority,:book_value


end
