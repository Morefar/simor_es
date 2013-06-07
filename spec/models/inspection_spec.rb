require 'spec_helper'

describe Inspection do

def create_asset
    body = create(:body, name: 'SUV')
    kind = create(:kind, name: 'Pickup')
    create(:build, body: body, kind: kind)
    create(:asset, body: body, kind: kind)
  end

  before (:each) do
    @asset = create_asset
  end

  it 'has a valid factory' do
    expect(build(:inspection, asset: @asset)).to be_valid
  end

  it { should belong_to(:asset) }
  it { should have_one(:inventory) }
  it { should have_one(:contract).through(:asset) }

  it { should validate_presence_of(:inspection_number) }
  it { should validate_uniqueness_of(:inspection_number).scoped_to(:asset_id) }
  it { should validate_uniqueness_of(:inspection_number).case_insensitive }

  it { should validate_presence_of(:person_in_charge) }
  it { should validate_presence_of(:pic_id) }
  it { should validate_presence_of(:pic_job) }
  it { should validate_presence_of(:date) }

  describe 'has valid soat dates' do
    context "soat doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, soat_number: nil, soat_begin_date: nil, soat_finish_date: nil)).to be_valid
      end
      it "is invalid when soat dates are present" do
        inspection = build(:inspection, asset: @asset, soat_number: nil)
        expect(inspection).to have(1).errors_on(:soat_begin_date)
        expect(inspection).to have(1).errors_on(:soat_finish_date)
      end
    end
    context 'soat is present' do
      it "is invalid when both soat dates are nil" do
        inspection = build(:inspection, asset: @asset, soat_number: 'OJ19294', soat_begin_date: nil, soat_finish_date: nil)
        expect(inspection).to have(1).errors_on(:soat_begin_date)
        expect(inspection).to have(1).errors_on(:soat_finish_date)
      end
      it 'is invalid when both soat dates are empty' do
        inspection = build(:inspection, asset: @asset, soat_number: 'OJ19294', soat_begin_date: '', soat_finish_date: '')
        expect(inspection).to have(1).errors_on(:soat_begin_date)
        expect(inspection).to have(1).errors_on(:soat_finish_date)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, soat_number: 'OJ19294', soat_begin_date: '2013-12-20', soat_finish_date: nil)
        expect(inspection).to have(1).errors_on(:soat_finish_date)
        inspection.soat_finish_date = ''
        expect(inspection).to have(1).errors_on(:soat_finish_date)
        inspection.soat_begin_date = nil
        inspection.soat_finish_date = '2013-02-21'
        expect(inspection).to have(1).errors_on(:soat_begin_date)
        inspection.soat_begin_date = ''
        expect(inspection).to have(1).errors_on(:soat_begin_date)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, soat_number: 'OJ19294',
          soat_begin_date: '2013-12-20',
          soat_finish_date: '2012-12-21')).to have(1).errors_on(:soat_finish_date)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, soat_number: 'OJ19294',
          soat_begin_date: '2013-12-20',
          soat_finish_date: '2014-10-20')).to have(1).errors_on(:soat_finish_date)
      end
    end
  end

  describe 'has valid insurance dates' do
    context "insurance doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, insurance_number: nil, insurance_start: nil, insurance_finish: nil)).to be_valid
      end
      it "is invalid when insurance dates are present" do
        inspection = build(:inspection, asset: @asset, insurance_number: nil)
        expect(inspection).to have(1).errors_on(:insurance_start)
        expect(inspection).to have(1).errors_on(:insurance_finish)
      end
    end
    context 'insurance is present' do
      it "is invalid when both insurance dates are nil" do
        inspection = build(:inspection, asset: @asset, insurance_number: 'OJ19294', insurance_start: nil, insurance_finish: nil)
        expect(inspection).to have(1).errors_on(:insurance_start)
        expect(inspection).to have(1).errors_on(:insurance_finish)
      end
      it 'is invalid when both insurance dates are empty' do
        inspection = build(:inspection, asset: @asset, insurance_number: 'OJ19294', insurance_start: '', insurance_finish: '')
        expect(inspection).to have(1).errors_on(:insurance_start)
        expect(inspection).to have(1).errors_on(:insurance_finish)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, insurance_number: 'OJ19294', insurance_start: '2013-12-20', insurance_finish: nil)
        expect(inspection).to have(1).errors_on(:insurance_finish)
        inspection.insurance_finish = ''
        expect(inspection).to have(1).errors_on(:insurance_finish)
        inspection.insurance_start = nil
        inspection.insurance_finish = '2013-02-21'
        expect(inspection).to have(1).errors_on(:insurance_start)
        inspection.insurance_start = ''
        expect(inspection).to have(1).errors_on(:insurance_start)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, insurance_number: 'OJ19294',
          insurance_start: '2013-12-20',
          insurance_finish: '2012-12-20')).to have(1).errors_on(:insurance_finish)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, insurance_number: 'OJ19294',
          insurance_start: '2013-12-20',
          insurance_finish: '2014-10-20')).to have(1).errors_on(:insurance_finish)
      end
    end
  end

  describe 'has valid gas certificate dates' do
    context "gas cartificate doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, gas_certificate: nil, gas_begin_date: nil, gas_finish_date: nil)).to be_valid
      end
      it "is invalid when gas certificate dates are present" do
        inspection = build(:inspection, asset: @asset, gas_certificate: nil)
        expect(inspection).to have(1).errors_on(:gas_begin_date)
        expect(inspection).to have(1).errors_on(:gas_finish_date)
      end
    end
    context 'gas certificate is present' do
      it "is invalid when both gas certificate dates are nil" do
        inspection = build(:inspection, asset: @asset, gas_certificate: 'OJ19294', gas_begin_date: nil, gas_finish_date: nil)
        expect(inspection).to have(1).errors_on(:gas_begin_date)
        expect(inspection).to have(1).errors_on(:gas_finish_date)
      end
      it 'is invalid when both gas certificate dates are empty' do
        inspection = build(:inspection, asset: @asset, gas_certificate: 'OJ19294', gas_begin_date: '', gas_finish_date: '')
        expect(inspection).to have(1).errors_on(:gas_begin_date)
        expect(inspection).to have(1).errors_on(:gas_finish_date)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, gas_certificate: 'OJ19294', gas_begin_date: '2013-12-20', gas_finish_date: nil)
        expect(inspection).to have(1).errors_on(:gas_finish_date)
        inspection.gas_finish_date = ''
        expect(inspection).to have(1).errors_on(:gas_finish_date)
        inspection.gas_begin_date = nil
        inspection.gas_finish_date = '2013-02-21'
        expect(inspection).to have(1).errors_on(:gas_begin_date)
        inspection.gas_begin_date = ''
        expect(inspection).to have(1).errors_on(:gas_begin_date)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, gas_certificate: 'OJ19294',
          gas_begin_date: '2013-12-20',
          gas_finish_date: '2012-12-20')).to have(1).errors_on(:gas_finish_date)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, gas_certificate: 'OJ19294',
          gas_begin_date: '2013-12-20',
          gas_finish_date: '2014-10-20')).to have(1).errors_on(:gas_finish_date)
      end
    end
  end

end