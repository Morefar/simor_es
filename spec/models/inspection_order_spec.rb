require 'spec_helper'

describe InspectionOrder do

  it { should allow_mass_assignment_of :asset_unique_identifier }
  it { should allow_mass_assignment_of :contract_url }
  it { should allow_mass_assignment_of :current_status }
  it { should allow_mass_assignment_of :notes }
  it { should allow_mass_assignment_of :recurring }
  it { should allow_mass_assignment_of :renew_period }
  it { should have_many :status_updates }

  it { should validate_presence_of :asset_unique_identifier }
  it { should validate_presence_of :contract_url }
  it { should validate_presence_of :notes}

  it { should validate_numericality_of :renew_period }
  it { should allow_value('OPEN', 'ASSIGNED', 'PENDING', 'CLOSED').for(:current_status) }
  it { should_not allow_value('1', 'ANYOTHER').for(:current_status) }

end
