require 'rails_helper'

describe InspectionOrder, :type => :model do

  it { is_expected.to have_many :notes }
  it { is_expected.to have_many :documents }
  it { is_expected.to have_one :inspection }
  it { is_expected.to belong_to :asset }
  it { is_expected.to belong_to(:requested_by).class_name("User") }

  context "if recurring is set to true" do
    before { allow(subject).to receive(:recurring?) { true } }
    it { is_expected.to validate_presence_of(:renew_period) }
    it do
      is_expected.to validate_numericality_of(:renew_period).
        only_integer.is_greater_than(0).
        is_less_than(13)
    end
  end
  context "if recurring is set to false" do
    before { allow(subject).to receive(:recurring?) { false } }
    it { is_expected.not_to validate_presence_of (:renew_period) }
    it do
      is_expected.not_to validate_numericality_of(:renew_period)
    end
  end
  it { is_expected.to ensure_inclusion_of(:status).
       in_array(%w(generated pending scheduled inspected)) }
  it { is_expected.to ensure_inclusion_of(:priority).
       in_array(%w(normal high)) }

end

# ## Schema Information
#
# Table name: `inspection_orders`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`id`**              | `integer`          | `not null, primary key`
# **`recurring`**       | `boolean`          | `default(FALSE)`
# **`renew_period`**    | `integer`          |
# **`status`**          | `string(255)`      |
# **`asset_id`**        | `integer`          |
# **`created_at`**      | `datetime`         | `not null`
# **`updated_at`**      | `datetime`         | `not null`
# **`scheduled_date`**  | `date`             |
# **`user_id`**         | `integer`          |
# **`priority`**        | `string(255)`      | `default("normal")`
#
