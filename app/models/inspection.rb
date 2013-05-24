class Inspection < ActiveRecord::Base
  attr_accessible :address, :city, :state, :date, :current_value, :appraiser_value, :soat_number,  :soat_begin_date, :soat_finish_date, :gas_certificate, :gas_begin_date, :gas_finish_date, :maintenance, :repairs, :security, :exterior, :interior, :engine, :accesories, :insurance_number, :insurance_company, :insured_value, :currency, :insurance_start, :insurance_finish, :person_in_charge, :pic_id, :pic_job

  belongs_to :asset
  has_one :contract, through: :asset
  # has_one :inventory

end
