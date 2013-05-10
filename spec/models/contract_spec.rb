require 'spec_helper'

describe Contract do
  it 'is valid with a unique contract number'
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
