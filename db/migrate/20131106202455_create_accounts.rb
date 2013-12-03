class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string :organization_name
      t.string :subdomain
      t.timestamps
    end
  end
  def down
    drop_table :accounts
  end
end
