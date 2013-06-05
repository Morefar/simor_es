class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :inspection_number
      t.references :asset
      t.string :address
      t.string :city
      t.string :state
      t.time :date
      t.float :current_value
      t.integer :appraiser_value
      t.string :soat_number
      t.string  :soat_begin_date
      t.string :soat_finish_date
      t.string :gas_certificate
      t.string :gas_begin_date
      t.string :gas_finish_date
      t.string :maintenance
      t.string :repairs
      t.string :security
      t.string :exterior
      t.string :interior
      t.string :engine
      t.string :accesories
      t.string :insurance_number
      t.string :insurance_company
      t.string :insured_value
      t.string :currency
      t.string :insurance_start
      t.string :insurance_finish
      t.string :person_in_charge
      t.string :pic_id
      t.string :pic_job
      t.timestamps
    end
  end
end
