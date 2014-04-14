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

class InspectionOrder < ActiveRecord::Base
  include AASM
  include Tokenable
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }

  #-- Relationships --------------------
  belongs_to :requested_by, class_name: 'User', foreign_key: "user_id"
  belongs_to :asset
  has_one :inspection, inverse_of: :inspection_order
  has_many :notes, class_name: 'Comment', as: :commentable
  has_many :documents, as: :documentable

  #-- Delegations ----------------------
  delegate :license_plate, :make_name, :model_name, :year, :service_type,
  :chassis_number, :kind_name, to: :asset, prefix:  true
  delegate :full_name, :email, to: :requested_by, prefix: :requester

  #-- Validations ----------------------
  validates :renew_period, numericality: { only_integer: true,
                                           greater_than: 0,
                                           less_than: 13 },
                                           if: "recurring?"
  validates :recurring, inclusion: { in: [true, false] }
  validates :renew_period, presence: true, if: "recurring?"
  validates :status, inclusion: %w(generated pending scheduled inspected)
  validates :priority, inclusion: %w(high normal)

  #-- Callbacks ------------------------
  before_destroy :check_state

  #-- Scopes ---------------------------
  scope :by_recency, -> { order("created_at DESC") }
  scope :by_updates, -> { order("updated_at DESC") }
  scope :by_range, ->(range) { where(created_at: range).by_recency }
  scope :by_asset, -> (license_plate) { self.joins(:asset).where("assets.license_plate ilike ?", license_plate) }
  scope :by_contract, -> (contract_number) { self.joins(asset: :contract).where("contracts.number ilike ?", contract_number) }

  #-- Class Methods --------------------
  def self.search(args)
    if args.has_key? :options
      query = parse_query(args)
      send(args[:options].to_s, query)
    else
      all.by_recency
    end
  end

  #-- Instance Methods -----------------
  def change_state(args)
    status_message = {"delay" => "Pospuesto: ", "schedule" => "Agendado: "}
    note_content = status_message[args[:status]] + args[:notes][:content]
    self.notes.build(content: note_content,
                     user: User.find(args[:notes][:user_id]))
    updated_attributes = args.except(:notes, :status)
    self.attributes = updated_attributes
    send("#{args[:status]}!")
  end

  aasm  column: "status" do
    state :generated, initial: true
    state :pending
    state :scheduled
    state :inspected

    event :schedule do
      transitions from: [:generated, :pending], to: :scheduled,
        guard: :valid_scheduled_date?
    end

    event :delay do
      transitions from: [:generated, :scheduled], to: :pending,
        before_enter: :wipe_scheduled_date
    end

    event :revert_inspected do
      transitions from: :inspected, to: :scheduled, on_transition: :clear_inspection
    end

    event :close do
      transitions from: :scheduled, to: :inspected
    end
  end

  def valid_scheduled_date?
    scheduled_date.present? && (scheduled_date >= Date.today)
  end

  def wipe_scheduled_date
    self.scheduled_date = nil
  end

  def clear_inspection
    self.inspection = nil
  end

  def check_state
    if inspected?
      self.errors[:base] << "No se puede borrar una vez ha sido generada la inspección"
    end
    !inspected?
  end

  private
  def self.parse_query(args)
    return "" if args[:query].blank?
    case args[:options].to_s
    when "by_range"
      dates = args[:query].split('-')
      begin
        start = Date.strptime(dates[0].strip, '%d/%m/%Y')
        finish = dates[1] ? Date.strptime(dates[1].strip, '%d/%m/%Y') : Date.today
        start..finish
      rescue
        Date.today..Date.today
      end
    else
      "%#{args[:query]}%"
    end
  end
end
