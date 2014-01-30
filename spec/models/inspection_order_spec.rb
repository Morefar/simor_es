require 'spec_helper'

describe InspectionOrder do

  it { should have_many :notes }
  it { should have_many :documents }
  it { should have_one :inspection }
  it { should belong_to :asset }
  it { should ensure_inclusion_of( :recurring ).in_array([true, false]) }

  context "if recurring is set to true" do
    before { subject.stub(:recurring?) { true } }
    it { should validate_presence_of(:renew_period) }
    it do
      should validate_numericality_of(:renew_period).
        only_integer.is_greater_than(0).
        is_less_than(13)
    end
  end
  context "if recurring is set to false" do
    before { subject.stub(:recurring?) { false } }
    it { should_not validate_presence_of (:renew_period) }
    it do
      should_not validate_numericality_of(:renew_period)
    end
  end
  it { should allow_value('generated', 'pending', 'scheduled', 'inspected').for(:status) }
  it { should_not allow_value('1', 'ANYOTHER').for(:status) }

end
