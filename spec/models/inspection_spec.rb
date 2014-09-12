require 'rails_helper'

describe Inspection, :type => :model do

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

  it { is_expected.to belong_to(:asset) }
  it { is_expected.to have_one(:inventory) }
  it { is_expected.to have_one(:contract).through(:asset) }

  it { is_expected.to validate_presence_of(:inspection_number) }
  it { is_expected.to validate_presence_of(:asset) }
  it 'validates uniqueness of the inspection number scoped to the asset' do
    create(:inspection, inspection_number: 1, asset: @asset)
    expect(build(:inspection, inspection_number: 1, asset: @asset).errors_on(:inspection_number).size).to eq(1)
    expect(build(:inspection, inspection_number: 2, asset: @asset)).to be_valid
   end

  it { is_expected.to validate_presence_of(:person_in_charge) }
  it { is_expected.to validate_presence_of(:pic_id) }
  it { is_expected.to validate_presence_of(:pic_job) }
  it { is_expected.to validate_presence_of(:inspection_date) }

  describe 'has valid soat dates' do
    context "soat doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, soat_number: nil, soat_begin_date: nil, soat_finish_date: nil)).to be_valid
      end
    end
    context 'soat is present' do
      it "is invalid when both soat dates are nil" do
        inspection = build(:inspection, asset: @asset, soat_number: 'OJ19294', soat_begin_date: nil, soat_finish_date: nil)
        expect(inspection.errors_on(:soat_begin_date).size).to eq(1)
        expect(inspection.errors_on(:soat_finish_date).size).to eq(1)
      end
      it 'is invalid when both soat dates are empty' do
        inspection = build(:inspection, asset: @asset, soat_number: 'OJ19294', soat_begin_date: '', soat_finish_date: '')
        expect(inspection.errors_on(:soat_begin_date).size).to eq(1)
        expect(inspection.errors_on(:soat_finish_date).size).to eq(1)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, soat_number: 'OJ19294', soat_begin_date: '2013-12-20', soat_finish_date: nil)
        expect(inspection.errors_on(:soat_finish_date).size).to eq(1)
        inspection.soat_finish_date = ''
        expect(inspection.errors_on(:soat_finish_date).size).to eq(1)
        inspection.soat_begin_date = nil
        inspection.soat_finish_date = '2013-02-21'
        expect(inspection.errors_on(:soat_begin_date).size).to eq(1)
        inspection.soat_begin_date = ''
        expect(inspection.errors_on(:soat_begin_date).size).to eq(1)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, soat_number: 'OJ19294',
          soat_begin_date: '2013-12-20',
          soat_finish_date: '2012-12-21').errors_on(:soat_finish_date).size).to eq(1)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, soat_number: 'OJ19294',
          soat_begin_date: '2013-12-20',
          soat_finish_date: '2014-10-20').errors_on(:soat_finish_date).size).to eq(1)
      end
    end
  end

  describe 'has valid insurance dates' do
    context "insurance doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, insurance_number: nil, insurance_start: nil, insurance_finish: nil)).to be_valid
      end
    end
    context 'insurance is present' do
      it "is invalid when both insurance dates are nil" do
        inspection = build(:inspection, asset: @asset, insurance_number: 'OJ19294', insurance_start: nil, insurance_finish: nil)
        expect(inspection.errors_on(:insurance_start).size).to eq(1)
        expect(inspection.errors_on(:insurance_finish).size).to eq(1)
      end
      it 'is invalid when both insurance dates are empty' do
        inspection = build(:inspection, asset: @asset, insurance_number: 'OJ19294', insurance_start: '', insurance_finish: '')
        expect(inspection.errors_on(:insurance_start).size).to eq(1)
        expect(inspection.errors_on(:insurance_finish).size).to eq(1)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, insurance_number: 'OJ19294', insurance_start: '2013-12-20', insurance_finish: nil)
        expect(inspection.errors_on(:insurance_finish).size).to eq(1)
        inspection.insurance_finish = ''
        expect(inspection.errors_on(:insurance_finish).size).to eq(1)
        inspection.insurance_start = nil
        inspection.insurance_finish = '2013-02-21'
        expect(inspection.errors_on(:insurance_start).size).to eq(1)
        inspection.insurance_start = ''
        expect(inspection.errors_on(:insurance_start).size).to eq(1)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, insurance_number: 'OJ19294',
          insurance_start: '2013-12-20',
          insurance_finish: '2012-12-20').errors_on(:insurance_finish).size).to eq(1)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, insurance_number: 'OJ19294',
          insurance_start: '2013-12-20',
          insurance_finish: '2014-10-20').errors_on(:insurance_finish).size).to eq(1)
      end
    end
  end

  describe 'has valid emissions certificate dates' do
    context "emissions cartificate doesn't exist" do
      it "is valid with empty dates" do
        expect(build(:inspection, asset: @asset, emissions_certificate: nil, emissions_begin_date: nil, emissions_finish_date: nil)).to be_valid
      end
    end
    context 'emissions certificate is present' do
      it "is invalid when both emissions certificate dates are nil" do
        inspection = build(:inspection, asset: @asset, emissions_certificate: 'OJ19294', emissions_begin_date: nil, emissions_finish_date: nil)
        expect(inspection.errors_on(:emissions_begin_date).size).to eq(1)
        expect(inspection.errors_on(:emissions_finish_date).size).to eq(1)
      end
      it 'is invalid when both emissions certificate dates are empty' do
        inspection = build(:inspection, asset: @asset, emissions_certificate: 'OJ19294', emissions_begin_date: '', emissions_finish_date: '')
        expect(inspection.errors_on(:emissions_begin_date).size).to eq(1)
        expect(inspection.errors_on(:emissions_finish_date).size).to eq(1)
      end
      it 'is invalid when one of the dates is nil' do
        inspection = build(:inspection, asset: @asset, emissions_certificate: 'OJ19294', emissions_begin_date: '2013-12-20', emissions_finish_date: nil)
        expect(inspection.errors_on(:emissions_finish_date).size).to eq(1)
        inspection.emissions_finish_date = ''
        expect(inspection.errors_on(:emissions_finish_date).size).to eq(1)
        inspection.emissions_begin_date = nil
        inspection.emissions_finish_date = '2013-02-21'
        expect(inspection.errors_on(:emissions_begin_date).size).to eq(1)
        inspection.emissions_begin_date = ''
        expect(inspection.errors_on(:emissions_begin_date).size).to eq(1)
      end
      it 'is invalid if the expiration date is earlier than the start date' do
        expect(build(:inspection, asset: @asset, emissions_certificate: 'OJ19294',
          emissions_begin_date: '2013-12-20',
          emissions_finish_date: '2012-12-20').errors_on(:emissions_finish_date).size).to eq(1)
      end
      it 'is invalid if the expiration date is less than one year from the start date' do
        expect(build(:inspection, asset: @asset, emissions_certificate: 'OJ19294',
          emissions_begin_date: '2013-12-20',
          emissions_finish_date: '2014-10-20').errors_on(:emissions_finish_date).size).to eq(1)
      end
    end
  end

end

# ## Schema Information
#
# Table name: `inspections`
#
# ### Columns
#
# Name                         | Type               | Attributes
# ---------------------------- | ------------------ | ---------------------------
# **`id`**                     | `integer`          | `not null, primary key`
# **`inspection_number`**      | `string(255)`      |
# **`asset_id`**               | `integer`          |
# **`address`**                | `string(255)`      |
# **`city`**                   | `string(255)`      |
# **`state`**                  | `string(255)`      |
# **`current_value`**          | `float`            |
# **`appraiser_value`**        | `integer`          |
# **`soat_number`**            | `string(255)`      |
# **`soat_begin_date`**        | `string(255)`      |
# **`soat_finish_date`**       | `string(255)`      |
# **`emissions_certificate`**  | `string(255)`      |
# **`emissions_begin_date`**   | `string(255)`      |
# **`emissions_finish_date`**  | `string(255)`      |
# **`exterior`**               | `string(255)`      |
# **`exterior_notes`**         | `text`             |
# **`interior`**               | `string(255)`      |
# **`interior_notes`**         | `text`             |
# **`engine`**                 | `string(255)`      |
# **`engine_notes`**           | `text`             |
# **`accesories`**             | `text`             |
# **`insurance_number`**       | `string(255)`      |
# **`insurance_company_id`**   | `integer`          |
# **`insured_value`**          | `integer`          |
# **`currency`**               | `string(255)`      |
# **`insurance_start`**        | `string(255)`      |
# **`insurance_finish`**       | `string(255)`      |
# **`person_in_charge`**       | `string(255)`      |
# **`pic_id`**                 | `string(255)`      |
# **`pic_job`**                | `string(255)`      |
# **`created_at`**             | `datetime`         | `not null`
# **`updated_at`**             | `datetime`         | `not null`
# **`observations`**           | `text`             |
# **`modifications`**          | `boolean`          | `default(FALSE)`
# **`odometer`**               | `string(255)`      | `default("0")`
# **`inspection_date`**        | `datetime`         |
# **`maintenance`**            | `boolean`          | `default(TRUE)`
# **`repairs`**                | `boolean`          | `default(TRUE)`
# **`security`**               | `boolean`          | `default(TRUE)`
# **`inspection_order_id`**    | `integer`          |
# **`overall_condition`**      | `string(255)`      |
#
