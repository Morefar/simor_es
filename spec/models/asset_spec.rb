#encoding: UTF-8

require 'rails_helper'

describe Asset, :type => :model do

  let(:contract) { build_stubbed(:contract) }

  it 'has a valid factory' do
    expect(build(:asset)).to be_valid
  end

  it { is_expected.to belong_to(:contract) }
  it { is_expected.to belong_to(:make) }
  it { is_expected.to belong_to(:model) }
  it { is_expected.to belong_to(:kind) }
  it { is_expected.to belong_to(:body) }
  it { is_expected.to belong_to(:color) }
  it { is_expected.to have_many(:inspections) }

  describe 'it invalid with an incorrectly formated license plate' do

    context 'special characters' do
      it 'is invalid when it has ñ' do
        expect(build(:asset,
          license_plate: 'AÑB123').errors_on(:license_plate).size).to eq(1)
      end
      it 'is invalid when it has spaces' do
        expect(build(:asset,
          license_plate: 'ACB 123').errors_on(:license_plate).size).to eq(2)
      end
      it 'is invalid when it has another special character' do
        expect(build(:asset,
          license_plate: 'A$B123').errors_on(:license_plate).size).to eq(1)
      end
    end

    context 'incorrect length' do
      it 'is invalid with more than 6 characters' do
        expect(build(:asset,
          license_plate: 'DV29023').errors_on(:license_plate).size).to eq(2)
      end

      it 'is invalid with less than 6 characters' do
        expect(build(:asset,
          license_plate: 'DV123').errors_on(:license_plate).size).to eq(2)
      end
    end

    it 'is invalid with numbers in it\'s first two characters' do
      expect(build(:asset,
        license_plate: '2D3098').errors_on(:license_plate).size).to eq(1)
      expect(build(:asset,
        license_plate: 'D23098').errors_on(:license_plate).size).to eq(1)
    end

    context 'new licence plate' do
      it 'is valid with three letters first and 3 digits' do
        expect(build(:asset,
          license_plate: 'IDN345')).to be_valid
      end
    end

    context 'old license plate' do
      it 'is valid with 2 letters first and 4 digits afterwards' do
        expect(build(:asset,
          license_plate: 'EG3459')).to be_valid
      end
    end
  end

  describe 'must have a valid cylinder capacity' do
    it 'is invalid with a cylinder capacity greater than 8000' do
      expect(build(:asset, contract: contract, cylinder_cap: 8001).errors_on(:cylinder_cap).size).to eq(1)
      expect(build(:asset, contract: contract, cylinder_cap: 8000)).to be_valid
    end

    it 'is invalid with a cylinder capacity less than 50' do
      expect(build(:asset, contract: contract, cylinder_cap: 49).error_on(:cylinder_cap).size).to eq(1)
      expect(build(:asset, contract: contract, cylinder_cap: 50)).to be_valid
    end

    it 'is invalid with a negative cylinder capacity' do
      expect(build(:asset, contract: contract, cylinder_cap: -1).error_on(:cylinder_cap).size).to eq(1)
    end
  end

  describe 'must have a valid capacity' do
    it 'is invalid if its not a number' do
      expect(build(:asset, capacity: 'five hundred').error_on(:capacity).size).to eq(1)
    end
    it 'is invalid if is greater than 3500' do
      expect(build(:asset, capacity: 3501).errors_on(:capacity).size).to eq(1)
    end
    it 'is invalid if is less than 2' do
      expect(build(:asset, capacity: 1).errors_on(:capacity).size).to eq(1)
    end
  end

  describe 'is valid if the vehicle\'s identification numbers are correctly formated' do

    context 'invalid size' do
      it 'is invalid if it\'s size is greater than 17 characters' do
        expect(build(:asset, contract: contract, serial_number: 'UJDK89698373EWD897').errors_on(:serial_number).size).to eq(1)
        expect(build(:asset, contract: contract, motor_number: 'EJDK89698373EWD897').errors_on(:motor_number).size).to eq(1)
        expect(build(:asset, contract: contract, chassis_number: 'AJDK89698373EWD897').errors_on(:chassis_number).size).to eq(1)
        expect(build(:asset, contract: contract, vin: 'PJDK89698373EWD897').errors_on(:vin).size).to eq(1)
      end

      it 'is invalid if it\'s size is smaller than 17 characters' do
        expect(build(:asset, contract: contract, chassis_number: 'UHEB1287097SHM').errors_on(:chassis_number).size).to eq(1)
        expect(build(:asset, contract: contract, vin: 'UHEB1287097SHM').errors_on(:vin).size).to eq(1)
      end
    end

    context 'Vehicle Identification Number' do
      it "is invalid if the VIN contains the letters 'I', 'O', 'Q', or 'Ñ'" do
        expect(build(:asset, contract: contract, vin: 'UHEB12I7097SHM863').errors_on(:vin).size).to eq(1)
        expect(build(:asset, contract: contract, vin: 'UHEB12O7097SHM863').errors_on(:vin).size).to eq(1)
        expect(build(:asset, contract: contract, vin: 'UHEB12Q7097SHM863').errors_on(:vin).size).to eq(1)
        expect(build(:asset, contract: contract, vin: 'UHEB12Ñ7097SHM863').errors_on(:vin).size).to eq(1)
      end
    end
  end

  describe "Valid Make - Model combination" do
    it 'is valid when an asset is created with a model that belongs to the make assigned' do
      make = create(:make, name: "make_test")
      model = create(:model, make: make, name: "model_that_belongs_to_make_test")
      attributes = { make: make, model: model }
      expect(build(:asset, attributes)).to be_valid
    end

    it "is invalid when created with a model that doesn't belong to the same make assigned" do
      make_with_model    = create(:make, name: "make_with_model")
      make_without_model = create(:make, name: "make_without_a_model")
      vehicle_model = create(:model, make: make_with_model, name: "model_belongs_to_make")
      attributes = { make: make_without_model, model: vehicle_model }
      expect(build(:asset, attributes).errors_on(:model_name).size).to eq(1)
    end
  end
end

# ## Schema Information
#
# Table name: `assets`
#
# ### Columns
#
# Name                        | Type               | Attributes
# --------------------------- | ------------------ | ---------------------------
# **`id`**                    | `integer`          | `not null, primary key`
# **`contract_id`**           | `integer`          |
# **`invoice_id`**            | `integer`          |
# **`inventory_number`**      | `string(255)`      |
# **`transit_permit`**        | `string(255)`      |
# **`license_plate`**         | `string(255)`      |
# **`make_id`**               | `integer`          |
# **`model_id`**              | `integer`          |
# **`year`**                  | `integer`          |
# **`cylinder_cap`**          | `integer`          |
# **`color_id`**              | `integer`          |
# **`service_type`**          | `string(255)`      |
# **`kind_id`**               | `integer`          |
# **`body_id`**               | `integer`          |
# **`fuel_type`**             | `string(255)`      |
# **`capacity`**              | `integer`          |
# **`motor_number`**          | `string(255)`      |
# **`rerecorded_motor`**      | `boolean`          |
# **`vin`**                   | `string(255)`      |
# **`serial_number`**         | `string(255)`      |
# **`rerecorded_serial`**     | `boolean`          |
# **`chassis_number`**        | `string(255)`      |
# **`rerecorded_chassis`**    | `boolean`          |
# **`mobility_restriction`**  | `string(255)`      |
# **`shield_level`**          | `integer`          |
# **`horse_power`**           | `string(255)`      |
# **`importd_assembld`**      | `boolean`          |
# **`import_statement`**      | `string(255)`      |
# **`import_date`**           | `string(255)`      |
# **`number_of_doors`**       | `integer`          |
# **`property_limitation`**   | `string(255)`      |
# **`registration_date`**     | `string(255)`      |
# **`tp_issue_date`**         | `string(255)`      |
# **`tp_expiration_date`**    | `string(255)`      |
# **`transit_authority`**     | `string(255)`      |
# **`book_value`**            | `float`            |
# **`inspection_count`**      | `integer`          | `default(0)`
# **`last_inspection_date`**  | `date`             |
# **`created_at`**            | `datetime`         | `not null`
# **`updated_at`**            | `datetime`         | `not null`
#
