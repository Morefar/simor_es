require 'spec_helper'

describe InspectionOrder do

  it { should have_many :notes }
  it { should have_many :documents }
  it { should have_one :inspection }
  it { should belong_to :asset }
  it { should belong_to(:requested_by).class_name("User") }

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
  it { should ensure_inclusion_of(:status).
       in_array(%w(generated pending scheduled inspected)) }
  it { should ensure_inclusion_of(:priority).
       in_array(%w(normal high)) }

end
