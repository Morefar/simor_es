class CreateIdentificationTypes < ActiveRecord::Migration
  def change
    create_table :identification_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
