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
  it { should validate_presence_of(:asset) }
  it 'validates uniqueness of the inspection number scoped to the asset' do
    create(:inspection, inspection_number: 1, asset: @asset)
    expect(build(:inspection, inspection_number: 1, asset: @asset)).to have(1).errors_on(:inspection_number)
    expect(build(:inspection, inspection_number: 2, asset: @asset)).to be_valid
   end

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

  describe 'has valid emissions certificate dates' do
    context "emissions cartificate doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, emissions_certificate: nil, emissions_begin_date: nil, emissions_finish_date: nil)).to be_valid
      end
      it "is invalid when emissions certificate dates are present" do
        inspection = build(:inspection, asset: @asset, emissions_certificate: nil)
        expect(inspection).to have(1).errors_on(:emissions_begin_date)
        expect(inspection).to have(1).errors_on(:emissions_finish_date)
      end
    end
    context 'emissions certificate is present' do
      it "is invalid when both emissions certificate dates are nil" do
        inspection = build(:inspection, asset: @asset, emissions_certificate: 'OJ19294', emissions_begin_date: nil, emissions_finish_date: nil)
        expect(inspection).to have(1).errors_on(:emissions_begin_date)
        expect(inspection).to have(1).errors_on(:emissions_finish_date)
      end
      it 'is invalid when both emissions certificate dates are empty' do
        inspection = build(:inspection, asset: @asset, emissions_certificate: 'OJ19294', emissions_begin_date: '', emissions_finish_date: '')
        expect(inspection).to have(1).errors_on(:emissions_begin_date)
        expect(inspection).to have(1).errors_on(:emissions_finish_date)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, emissions_certificate: 'OJ19294', emissions_begin_date: '2013-12-20', emissions_finish_date: nil)
        expect(inspection).to have(1).errors_on(:emissions_finish_date)
        inspection.emissions_finish_date = ''
        expect(inspection).to have(1).errors_on(:emissions_finish_date)
        inspection.emissions_begin_date = nil
        inspection.emissions_finish_date = '2013-02-21'
        expect(inspection).to have(1).errors_on(:emissions_begin_date)
        inspection.emissions_begin_date = ''
        expect(inspection).to have(1).errors_on(:emissions_begin_date)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, emissions_certificate: 'OJ19294',
          emissions_begin_date: '2013-12-20',
          emissions_finish_date: '2012-12-20')).to have(1).errors_on(:emissions_finish_date)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, emissions_certificate: 'OJ19294',
          emissions_begin_date: '2013-12-20',
          emissions_finish_date: '2014-10-20')).to have(1).errors_on(:emissions_finish_date)
      end
    end
  end

end
