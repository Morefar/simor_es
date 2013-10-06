#encoding: UTF-8

require 'spec_helper'


describe Asset do

  def create_build
      body = create(:body)
      kind = create(:kind)
      create(:build, body: body, kind: kind)
      { body: body, kind: kind }
  end

  before(:each) do
    @authorized_build = create_build
    identification_type = create(:identification_type, name: 'NIT')
    lessee = create(:entity, identification_type: identification_type)
    @contract = create(:contract, lessee: lessee)
  end

  it 'has a valid factory' do
    expect(build(:asset, body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
  end

  it { should belong_to(:contract) }
  it { should belong_to(:make) }
  it { should belong_to(:model) }
  it { should belong_to(:kind) }
  it { should belong_to(:body) }
  it { should belong_to(:color) }
  it { should have_many(:inspections) }

  describe 'it invalid with an incorrectly formated license plate' do

    context 'special characters' do
      it 'is invalid when it has ñ' do
        expect(build(:asset,
          license_plate: 'AÑB123', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:license_plate)
      end
      it 'is invalid when it has spaces' do
        expect(build(:asset,
          license_plate: 'ACB 123', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(2).errors_on(:license_plate)
      end
      it 'is invalid when it has another special character' do
        expect(build(:asset,
          license_plate: 'A$B123', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:license_plate)
      end
    end

    context 'incorrect length' do
      it 'is invalid with more than 6 characters' do
        expect(build(:asset,
          license_plate: 'DV29023', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(2).errors_on(:license_plate)
      end

      it 'is invalid with less than 6 characters' do
        expect(build(:asset,
          license_plate: 'DV123', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(2).errors_on(:license_plate)
      end
    end

    it 'is invalid with numbers in it\'s first two characters' do
      expect(build(:asset,
        license_plate: '2D3098', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:license_plate)
      expect(build(:asset, contract: @contract,
        license_plate: 'D23098', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:license_plate)
    end

    context 'new licence plate' do
      it 'is valid with three letters first and 3 digits' do
        expect(build(:asset,
          license_plate: 'IDN345', body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
      end
    end

    context 'old license plate' do
      it 'is valid with 2 letters first and 4 digits afterwards' do
        expect(build(:asset,
          license_plate: 'EG3459', body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
      end
    end
  end

  it 'is invalid if year is not between 2000 and 2014' do
    expect(build(:asset, contract: @contract, year: 1999, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:year)
    expect(build(:asset, contract: @contract, year: (Date.current >> 24).year, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:year)
    expect(build(:asset, contract: @contract, year: (Date.current >> 12).year, body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
    expect(build(:asset, contract: @contract, year: Date.current.year, body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
    expect(build(:asset, contract: @contract, year: (Date.current << 24).year, body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
  end

  describe 'must have a valid cylinder capacity' do
    it 'is invalid with a cylinder capacity greater than 8000' do
      expect(build(:asset, contract: @contract, cylinder_cap: 8001, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:cylinder_cap)
      expect(build(:asset, contract: @contract, cylinder_cap: 8000, body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
  end

    it 'is invalid with a cylinder capacity less than 50' do
      expect(build(:asset, contract: @contract, cylinder_cap: 49, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).error_on(:cylinder_cap)
      expect(build(:asset, contract: @contract, cylinder_cap: 50, body: @authorized_build[:body], kind: @authorized_build[:kind])).to be_valid
    end

    it 'is invalid with a negative cylinder capacity' do
      expect(build(:asset, contract: @contract, cylinder_cap: -1, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).error_on(:cylinder_cap)
    end
  end

  describe 'must have a valid capacity' do
    it 'is invalid if its not a number' do
      expect(build(:asset, capacity: 'five hundred', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).error_on(:capacity)
    end
    it 'is invalid if is greater than 3500' do
      expect(build(:asset, capacity: 3501, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:capacity)
    end
    it 'is invalid if is less than 2' do
      expect(build(:asset, capacity: 1, body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:capacity)
    end
  end

  describe 'is valid if the vehicle\'s identification numbers are correctly formated' do

    context 'invalid size' do
      it 'is invalid if it\'s size is greater than 17 characters' do
        expect(build(:asset, contract: @contract, serial_number: 'UJDK89698373EWD897', body: @build_hash[:body], kind: @build_hash[:kind])).to have(1).errors_on(:serial_number)
        expect(build(:asset, contract: @contract, motor_number: 'EJDK89698373EWD897', body: @build_hash[:body], kind: @build_hash[:kind])).to have(1).errors_on(:motor_number)
        expect(build(:asset, contract: @contract, chassis_number: 'AJDK89698373EWD897', body: @build_hash[:body], kind: @build_hash[:kind])).to have(1).errors_on(:chassis_number)
        expect(build(:asset, contract: @contract, vin: 'PJDK89698373EWD897', body: @build_hash[:body], kind: @build_hash[:kind])).to have(1).errors_on(:vin)
      end

      it 'is invalid if it\'s size is smaller than 17 characters' do
        expect(build(:asset, contract: @contract, chassis_number: 'UHEB1287097SHM', body: @build_hash[:body], kind: @build_hash[:kind])).to have(1).errors_on(:chassis_number)
        expect(build(:asset, contract: @contract, vin: 'UHEB1287097SHM', body: @build_hash[:body], kind: @build_hash[:kind])).to have(1).errors_on(:vin)
      end
    end

    context 'Vehicle Identification Number' do
      it "is invalid if the VIN contains the letters 'I', 'O', 'Q', or 'Ñ'" do
        expect(build(:asset, contract: @contract, vin: 'UHEB12I7097SHM863', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:vin)
        expect(build(:asset, contract: @contract, vin: 'UHEB12O7097SHM863', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:vin)
        expect(build(:asset, contract: @contract, vin: 'UHEB12Q7097SHM863', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:vin)
        expect(build(:asset, contract: @contract, vin: 'UHEB12Ñ7097SHM863', body: @authorized_build[:body], kind: @authorized_build[:kind])).to have(1).errors_on(:vin)
      end
    end
  end

  describe 'valid kind - body combination' do
      it 'is invalid if the build is not authorized' do
        kind = create(:kind, name: 'Vehiculo')
        body = create(:body, name: 'Grua')
        expect(build(:asset, kind: kind, body: body)).to have(1).errors_on(:kind)
      end
  end

  describe "Valid Make - Model combination" do
    it 'is valid when an asset is created with a model that belongs to the make assigned' do
      make = create(:make, name: "make_test")
      model = create(:model, make: make, name: "model_that_belongs_to_make_test")
      attributes = @authorized_build.merge(make: make, model: model)
      expect(build(:asset, attributes)).to be_valid
    end

    it "is invalid when created with a model that doesn't belong to the same make assigned" do
      make_with_model    = create(:make, name: "make_with_model")
      make_without_model = create(:make, name: "make_without_a_model")
      model = create(:model, make: make_with_model, name: "model_belongs_to_make")
      attributes = @authorized_build.merge(make: make_without_model, model: model)
      expect(build(:asset, attributes)).to have(1).errors_on(:model)
    end
  end
end
