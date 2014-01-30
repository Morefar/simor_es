class InspectionOrder < ActiveRecord::Base
  include AASM

  belongs_to :asset
  has_one :inspection
  has_many :notes, class_name: 'Comment', as: :commentable
  has_many :documents, as: :documentable

  validates :renew_period, numericality: { only_integer: true,
                                           greater_than: 0,
                                           less_than: 13 },
                                           if: "recurring?"
  validates :recurring, inclusion: { in: [true, false] }
  validates :renew_period, presence: true, if: "recurring?"
  validates :status, format: { with: /(generated|pending|scheduled|inspected)/ }

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
