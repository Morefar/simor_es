class InspectionOrder < ActiveRecord::Base
  include AASM

  belongs_to :requested_by, class_name: 'User', foreign_key: "user_id"
  belongs_to :asset
  has_one :inspection
  has_many :notes, class_name: 'Comment', as: :commentable
  has_many :documents, as: :documentable

  delegate :license_plate, :make_name, :model_name, :year, :service_type,
  :chassis_number, :kind_name, to: :asset, prefix:  true
  delegate :full_name, to: :requested_by, prefix: true
  validates :renew_period, numericality: { only_integer: true,
                                           greater_than: 0,
                                           less_than: 13 },
                                           if: "recurring?"
  validates :recurring, inclusion: { in: [true, false] }
  validates :renew_period, presence: true, if: "recurring?"
  validates :status, inclusion: %w(generated pending scheduled inspected)
  validates :priority, inclusion: %w(high normal)

  scope :by_creation, -> { order("created_at DESC") }

  aasm  column: "status" do
    state :generated, initial: true
    state :pending
    state :scheduled
    state :inspected

    event :schedule do
      transitions from: [:generated, :pending], to: :scheduled
    end

    event :delay do
      transitions from: [:generated, :scheduled], to: :pending
    end

    event :close do
      transitions from: :scheduled, to: :inspected
    end
  end
end
