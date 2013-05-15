require 'spec_helper'

describe Asset do

it 'has a valid factory'
describe 'it invalid with an incorrectly formated license plate' do
  it 'is invalid with special characters'
  it 'is invalid with more than 6 characters'
  it 'is invalid with less than 6 characters'

  context 'new licence plate' do
    it 'is valid with three letters and 3 digits'
    it 'is invalid without letters as the first 3 characters'
  end

  context 'old lincense plate' do
    it 'is valid with 2 letters and 4 digits'
    it 'is invalid without letters as the first 2 characters'
  end
end




end
