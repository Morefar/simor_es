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

  it 'is invalid if year is not within the defined range'
  describe 'must have a valid cylinder capacity' do
    it 'is invalid with a cylinder capacity greater than the accepted range'
    it 'is invalid with a cylinder capacity less than the accepted range'
    it 'is invalid with a negative cylinder capacity'
  end
  describe 'must have a valid capacity' do
    it 'is invalid if its not a number'
    it 'is invalid if is greater than the accepted range'
    it 'is invalid if is less than the accepted range'
  end
  describe 'is valid if the vehicle\'s identification numbers are correctly formated' do
    context 'Serial number' do
    end
    context 'Vehicle Identification Number' do
      it 'is invalid if it\'s size is greater than 17 characters'
      it 'is invalid if it\'s size is smaller than 17 characters'
      it "is invalid if the VIN contains the letters 'I', 'O', 'Q', or 'Ñ'"
    end
    context 'Chassis Number' do
    end
  end
end
