require 'spec_helper'

describe InsuranceCompany do

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:nit) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:nit) }
  it { should have_many(:inspections) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:nit) }
  it { should allow_value('Compañía Nacional de Seguros').for(:name) }
  it { should_not allow_value("Compañía 12").for(:name) }
  it { should allow_value('800220495', '800.220.495').for(:nit) }
  it { should_not allow_value('', '800.220,495', '900,345,908', '983,435.456', '890', '409.345.345-8').for(:nit)}
  it { should ensure_length_of(:nit).
    is_at_least(9).
    is_at_most(11) }

end
