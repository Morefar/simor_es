require 'rails_helper'

describe ContractPolicy do
  subject { ContractPolicy.new(current_user, contract) }

  context 'for an inspector' do
    let(:current_user) { build_stubbed(:user, roles: "inspector") }

    it { expect(subject).to permit(:show) }
    it { expect(subject).to permit(:index) }

    it { expect(subject).to_not permit(:new) }
    it { expect(subject).to_not permit(:create) }
    it { expect(subject).to_not permit(:edit) }
    it { expect(subject).to_not permit(:update) }
    it { expect(subject).to_not permit(:destroy) }
  end

end
