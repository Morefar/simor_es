require 'spec_helper'

describe Asset do

  it 'has a valid factory' do
    expect(build(:asset)).to be_valid
  end
  describe 'it invalid with an incorrectly formated license plate' do

    context 'special characters' do
      it 'is invalid when it has ñ' do
        expect(build(:asset,
          license_plate: 'AÑB123')).to have(1).errors_on(:license_plate)
      end
      it 'is invalid when it has spaces' do
        expect(build(:asset,
          license_plate: 'ACB 123')).to have(2).errors_on(:license_plate)
      end
      it 'is invalid when it has another special character' do
        expect(build(:asset,
          license_plate: 'A$B123')).to have(1).errors_on(:license_plate)
      end
    end

    context 'incorrect length' do
      it 'is invalid with more than 6 characters' do
        expect(build(:asset,
          license_plate: 'DV29023')).to have(2).errors_on(:license_plate)
      end

      it 'is invalid with less than 6 characters' do
        expect(build(:asset,
          license_plate: 'DV123')).to have(2).errors_on(:license_plate)
      end
    end

    it 'is invalid with numbers in it\'s first two characters' do
      expect(build(:asset,
        license_plate: '2D3098')).to have(1).errors_on(:license_plate)
      expect(build(:asset,
        license_plate: 'D23098')).to have(1).errors_on(:license_plate)
    end

    context 'new licence plate' do
      it 'is valid with three letters first and 3 digits' do
        expect(build(:asset,
          license_plate: 'IDN345')).to be_valid
      end
    end

    context 'old lincense plate' do
      it 'is valid with 2 letters first and 4 digits afterwards' do
        expect(build(:asset,
          license_plate: 'EG3459')).to be_valid
      end
    end
  end

  it 'is invalid if year is not between 2000 and 2014' do
    expect(build(:asset, year: 1999)).to have(1).errors_on(:year)
    expect(build(:asset, year: (Date.current >> 24).year)).to have(1).errors_on(:year)
    expect(build(:asset, year: (Date.current >> 12).year)).to be_valid
    expect(build(:asset, year: Date.current.year)).to be_valid
    expect(build(:asset, year: (Date.current << 24).year)).to be_valid
  end

  describe 'must have a valid cylinder capacity' do
    it 'is invalid with a cylinder capacity greater than 8000' do
      expect(build(:asset, cylinder_cap: 8001)).to have(1).errors_on(:cylinder_cap)
      expect(build(:asset, cylinder_cap: 8000)).to be_valid
  end

    it 'is invalid with a cylinder capacity less than 50' do
      expect(build(:asset, cylinder_cap: 49)).to have(1).error_on(:cylinder_cap)
      expect(build(:asset, cylinder_cap: 50)).to be_valid
    end

    it 'is invalid with a negative cylinder capacity' do
      expect(build(:asset, cylinder_cap: -1)).to have(1).error_on(:cylinder_cap)
    end
  end

  describe 'must have a valid capacity' do
    it 'is invalid if its not a number' do
      expect(build(:asset, capacity: 'five hundred')).to have(1).error_on(:capacity)
    end
    it 'is invalid if is greater than 3500' do
      expect(build(:asset, capacity: 3501)).to have(1).errors_on(:capacity)
    end
    it 'is invalid if is less than 2' do
      expect(build(:asset, capacity: 1)).to have(1).errors_on(:capacity)
    end
  end

  describe 'is valid if the vehicle\'s identification numbers are correctly formated' do

    context 'invalid size' do
      it 'is invalid if it\'s size is greater than 17 characters' do
        expect(build(:asset, serial_number: 'UJDK89698373EWD897')).to have(1).errors_on(:serial_number)
        expect(build(:asset, motor_number: 'EJDK89698373EWD897')).to have(1).errors_on(:motor_number)
        expect(build(:asset, chassis_number: 'AJDK89698373EWD897')).to have(1).errors_on(:chassis_number)
        expect(build(:asset, vin: 'PJDK89698373EWD897')).to have(1).errors_on(:vin)
      end

      it 'is invalid if it\'s size is smaller than 17 characters' do
        expect(build(:asset, serial_number: 'UHEB1287097SHM')).to have(1).errors_on(:serial_number)
        expect(build(:asset, motor_number: 'UHEB1287097SHM')).to have(1).errors_on(:motor_number)
        expect(build(:asset, chassis_number: 'UHEB1287097SHM')).to have(1).errors_on(:chassis_number)
        expect(build(:asset, vin: 'UHEB1287097SHM')).to have(1).errors_on(:vin)
      end
    end

    # context 'Serial number' do
    #   it 'is invalid with a duplicate serial number' do
    #     create(:asset, serial_number: 'UHEB1287097SHM863')
    #     expect(build(:asset, serial_number: 'UHEB1287097SHM863')).to have(1).errors_on(:serial_number)
    #   end
    # end

    context 'Vehicle Identification Number' do
      it "is invalid if the VIN contains the letters 'I', 'O', 'Q', or 'Ñ'" do
        expect(build(:asset, vin: 'UHEB12I7097SHM863')).to have(1).errors_on(:vin)
        expect(build(:asset, vin: 'UHEB12O7097SHM863')).to have(1).errors_on(:vin)
        expect(build(:asset, vin: 'UHEB12Q7097SHM863')).to have(1).errors_on(:vin)
        expect(build(:asset, vin: 'UHEB12Ñ7097SHM863')).to have(1).errors_on(:vin)
      end

      # it 'is invalid with a duplicate VIN' do
      #   create(:asset, vin: 'UHEB1287097SHM863')
      #   expect(build(:asset, vin: 'UHEB1287097SHM863')).to have(1).errors_on(:vin)
      # end

      it 'is invalid with a nil VIN' do
        expect(build(:asset, vin: nil)).to have(2).errors_on(:vin)
      end
    end

    # context 'Chassis Number' do
    #   # it 'is invalid with a duplicate chassis number' do
    #   #   create(:asset, chassis_number: 'UHEB1287097SHM863')
    #   #   expect(build(:asset, chassis_number: 'UHEB1287097SHM863')).to have(1).errors_on(:chassis_number)
    #   # end
    # end
  end
end
