require 'rails_helper'

describe Contract, :type => :model do
  it 'has a valid factory' do
    expect(build(:contract)).to be_valid
  end

  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:assets) }
  it { is_expected.to have_many(:inspections).through(:assets) }
  it { is_expected.to belong_to(:lessee) }
  it { is_expected.to have_many(:cosigners) }
  it { is_expected.to have_many(:entities).through(:cosigners) }

  it 'is valid with a unique contract number' do
    create(:contract, number: '10980984-9873')
    contract = build(:contract, number: '10980984-9874', lessee: create(:entity, identification_type: create(:identification_type, name: 'NIT')))
    expect(contract).to be_valid
  end

  # it 'is valid with a duplicate contract number from diferent clients' do
  #   create(:contract, number: '10980984-9873', client_id: 1)
  #   contract = build(:contract, number: '10980984-9873', client_id: 2, lessee: create(:entity, identification_type: create(:identification_type, name: 'NIT')))
  #   expect(contract).to be_valid
  # end

  # it  'is invalid with a duplicate contract number from the same client' do
  #   create(:contract, number: '10980984-9873', client_id: 1)
  #   contract = build(:contract, number: '10980984-9873', client_id: 1, lessee: create(:entity, identification_type: create(:identification_type, name: 'NIT')))
  #   expect(contract).to have(1).errors_on(:number)
  # end

  it 'is invalid with an expiration date earlier than a starting date' do

    expect(Contract.create(number: '10980984-9873',
    :category => Category.new(name: 'Financial'),
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago').errors_on(:expiration_date).size).to eq(1)
  end
  it 'is invalid with a first canon date earlier than a starting date' do
    expect(Contract.create(number: '10980984-9873',
    :category => Category.new(name: 'Financial'),
    :client_id => 1,
    :lessee => create(:entity),
    :start_date => Date.current,
    :first_canon_date => Date.current << 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago').errors_on(:first_canon_date).size).to eq(1)
    expect(Contract.create(number: '10980984-9873',
    :category => Category.new(name: 'Operational'),
    :lessee => create(:entity, identification_type: create(:identification_type, name: 'NIT')),
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago')).to be_valid
  end

  it 'is invalid with a negative duration' do
    contract = build(:contract, duration: -2)
    expect(contract).to be_invalid
    expect(contract.errors_on(:duration).size).to eq(1)
    expect(contract.errors_on(:expiration_date).size).to eq(1)
  end

  describe 'is invalid with a float duration' do

    context 'negative duration' do
        it 'is invalid with a negative float duration' do
            expect(build(:contract,
                duration: -1.5).errors_on(:duration).size).to eq(1)
        end
    end

    context 'positive duration' do
        it 'in invalid with a positive float duration' do
            expect(build(:contract,
                duration: 1.5).errors_on(:duration).size).to eq(1)
        end
    end
  end

  it 'is invalid with a negative total value' do
    expect(build(:contract,
        total_value: -12_000_000).errors_on(:total_value).size).to eq(1)
  end

  it 'is invalid without a date when there is an option to buy' do
    expect(build(:contract, option_to_buy: true,
        last_date_to_option: nil).errors_on(:last_date_to_option).size).to eq(1)
  end

  describe '#asset_count' do
    it 'should return the correct number of assets included in this contract' do
      contract = create(:contract, number: 'lo123')
      create(:asset, license_plate: 'ABC123', contract: contract, vin: 'UHEB1287097SHM863', chassis_number: 'UHEB1287097SHM863')
      create(:asset, license_plate: 'ABC124', contract: contract, vin: 'UHEB1287097SHM864', chassis_number: 'UHEB1287097SHM864', serial_number: nil, motor_number: nil)
      create(:asset, license_plate: 'ABC125', contract: contract, vin: 'UHEB1287097SHM865', chassis_number: 'UHEB1287097SHM865', serial_number: nil, motor_number: nil)
      expect(contract.asset_count).to eq(3)
    end
  end
end

# ## Schema Information
#
# Table name: `contracts`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `integer`          | `not null, primary key`
# **`client_id`**            | `integer`          |
# **`lessee_id`**            | `integer`          |
# **`number`**               | `string(255)`      |
# **`category_id`**          | `integer`          |
# **`start_date`**           | `date`             |
# **`first_canon_date`**     | `date`             |
# **`duration`**             | `integer`          |
# **`periodicity`**          | `integer`          |
# **`expiration_date`**      | `date`             |
# **`total_value`**          | `float`            |
# **`currency`**             | `string(255)`      |
# **`asset_count`**          | `integer`          | `default(0)`
# **`location_of_assets`**   | `text`             |
# **`option_to_buy`**        | `boolean`          |
# **`last_date_to_option`**  | `date`             |
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
#
