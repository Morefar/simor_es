class InspectionOrder < ActiveRecord::Base
  attr_accessible :asset_unique_identifier, :contract_url, :current_status, :notes, :recurring, :renew_period

  has_many :status_updates, class_name: 'Comment', as: :commentable
  belongs_to :asset

  validates :asset_unique_identifier, :contract_url, :notes, presence: true
  validates :renew_period, numericality: { only_integers: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :current_status, format: { with: /\AOPEN|ASSIGNED|PENDING|CLOSED\Z/}
end
