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
      t.string :emissions_certificate
      t.string :emissions_begin_date
      t.string :emissions_finish_date
      t.text :maintenance
      t.text :repairs
      t.text :security
      t.string :exterior
      t.text :exterior_notes
      t.string :interior
      t.text :interior_notes
      t.string :engine
      t.text :engine_notes
      t.text :accesories
      t.string :insurance_number
      t.belongs_to :insurance_company
      t.integer :insured_value
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
