require 'spec_helper'

describe Contract do
  it 'is valid with a unique contract number' do
    category = Category.new
    category.name = 'Financial'
    category.save
    contract = Contract.new(number: '10980984-9873')
    contract.category = category
    contract.start_date = Date.current
    contract.first_canon_date = contract.start_date >> 1
    contract.duration = 24
    contract.periodicity = 1
    contract.expiration_date = contract.first_canon_date >> (contract.duration * contract.periodicity)
    contract.total_value = 275_878_878.90
    contract.currency = 'COP$'
    contract.asset_count = 1
    contract.location_of_assets = 'Chicago'
    expect(contract).to be_valid
  end
  it 'is valid with a correctly formated start date'
  it 'is invalid with an expiration date earlier than a starting date'
  it 'is invalid with a first canon date earlier than a starting date'
  it 'is invalid with an expiration date sooner or later than the duration of the contract'
  it 'is invalid with a negative duration'
  it 'is invalid with a float duration'
  it 'is invalid with a negative total value'
  it 'is invalid with a negative asset count'
  it 'is invalid with an option date when there is no option to buy'
  it 'is invalid without a date when there is an option to buy'
end
