require 'spec_helper'

describe Contract do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:contract)).to be_valid
  end
  it 'is valid with a unique contract number' do
    category = Category.new
    category.name = 'Financial'
    category.save
    contract = Contract.create(number: '10980984-9873',
    :category => category,
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago')
    contract2 = Contract.new(number: '10980984-9875',
    :category => category,
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago')
    expect(contract).to be_valid
    expect(contract2).to be_valid
  end

  it 'is valid with a duplicate contract number from diferent clients' do
    category = Category.new
    category.name = 'Financial'
    category.save
    contract = Contract.create(number: '10980984-9873',
    :category => Category.create(name: 'Financial'),
    :client_id => 2,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :location_of_assets => 'Chicago')
    contract2 = Contract.new(number: '10980984-9873',
    :category => Category.create(name: 'Operational'),
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :location_of_assets => 'Chicago')
    expect(contract).to be_valid
    expect(contract2).to be_valid
  end

  it  'is invalid with a duplicate contract number from the same client' do
    category = Category.new
    category.name = 'Financial'
    category.save
    contract = Contract.create(number: '10980984-9873',
    :category => category,
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 24,
    :periodicity => 1,
    :expiration_date => Date.current >> (24 * 1)+1,
    :total_value => 275_878_878.90,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago')
    contract2 = Contract.new(number: '10980984-9873',
    :category => category,
    :client_id => 1,
    :start_date => Date.current,
    :first_canon_date => Date.current >> 1,
    :duration => 60,
    :periodicity => 1,
    :expiration_date => Date.current >> (60 * 1)+1,
    :total_value => 275_000_000.00,
    :currency => 'COP$',
    :asset_count => 1,
    :location_of_assets => 'Chicago')
    expect(contract).to be_valid
    expect(contract2).to have(1).errors_on(:number)
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

  it 'is invalid with an expiration date sooner or later than the duration of the contract' do
  end

  it 'is invalid with a negative duration'
  it 'is invalid with a float duration'
  it 'is invalid with a negative total value'
  it 'is invalid with an option date when there is no option to buy'
  it 'is invalid without a date when there is an option to buy'
  it 'is valid with a correctly formated start date'
end
