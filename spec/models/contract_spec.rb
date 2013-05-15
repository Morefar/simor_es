require 'spec_helper'

describe Contract do

  it 'has a valid factory' do
    expect(build(:contract)).to be_valid
  end

  it 'is valid with a unique contract number' do
    create(:contract, number: '10980984-9873')
    contract = build(:contract, number: '10980984-9874')
    expect(contract).to be_valid
  end

  it 'is valid with a duplicate contract number from diferent clients' do

    create(:contract, number: '10980984-9873', client_id: 1)
    contract = build(:contract, number: '10980984-9873', client_id: 2)
    expect(contract).to be_valid
  end

  it  'is invalid with a duplicate contract number from the same client' do
    create(:contract, number: '10980984-9873', client_id: 1)
    contract = build(:contract, number: '10980984-9873', client_id: 1)
    expect(contract).to have(1).errors_on(:number)
  end

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
    :location_of_assets => 'Chicago')).to have(1).errors_on(:expiration_date)
  end
  it 'is invalid with a first canon date earlier than a starting date' do
    expect(Contract.create(number: '10980984-9873',
    :category => Category.new(name: 'Financial'),
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current << 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago')).to have(1).errors_on(:first_canon_date)
    expect(Contract.create(number: '10980984-9873',
    :category => Category.new(name: 'Operational'),
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
    expect(contract).to have(1).errors_on(:duration)
    expect(contract).to have(1).errors_on(:expiration_date)
    expect(contract).to have(1).errors_on(:start_date)

  end

  describe 'is invalid with a float duration' do

    context 'negative duration' do
        it 'is invalid with a negative float duration' do
            expect(build(:contract,
                duration: -1.5)).to have(1).errors_on(:duration)
        end
    end

    context 'positive duration' do
        it 'in invalid with a positive float duration' do
            expect(build(:contract,
                duration: 1.5)).to have(1).errors_on(:duration)
        end
    end
  end

  it 'is invalid with a negative total value' do
    expect(build(:contract,
        total_value: -12_000_000)).to have(1).errors_on(:total_value)
  end

  it 'is invalid with an option date when there is no option to buy' do
    expect(build(:contract, option_to_buy: false,
        last_date_to_option: Date.current)).to have(1).errors_on(:last_date_to_option)
  end
  it 'is invalid without a date when there is an option to buy' do
    expect(build(:contract, option_to_buy: true,
        last_date_to_option: nil)).to have(1).errors_on(:last_date_to_option)
  end


end
