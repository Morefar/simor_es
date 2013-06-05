class InspectionOrder < ActiveRecord::Base
  attr_accessible :asset_unique_identifier, :contract_url, :current_status, :notes, :recurring, :renew_period
end
