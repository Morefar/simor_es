class InspectionOrderForm < FormObject::Base

  attribute :number, String
  attribute :number_from, String
  attribute :requested_by, Integer
  attribute :inspection_order, InspectionOrder, default: InspectionOrder.new
  attribute :note, Comment, default: Comment.new

  delegate :recurring, :recurring=, :renew_period, :renew_period=, :status,
    :asset_id, :scheduled_date, :priority, :priority=,
    to: :inspection_order, allow_nil: true
  delegate :content, :content=, to: :note, prefix: true, allow_nil: true

  validate :model_must_exist
  validate :assets_present?

  def submit
    if valid?
      generated_orders = Array.new
      asset_ids.each do |asset|
        inspection_order = InspectionOrder.new(requested_by: requestor,
                                                asset_id: asset,
                                                recurring: recurring,
                                                renew_period: renew_period,
                                                priority: priority)
        note.attributes = { user_id: requestor.id,
                            commentable_type: inspection_order.class.to_s }
        inspection_order.notes << note
        generated_orders << inspection_order
      end
      InspectionOrder.transaction do
        generated_orders.each do |inspection_order|
          inspection_order.save!
        end
      end
    end
  end

  def inspection_order
    @inspection_order ||= InspectionOrder.new
  end

  def note
    @note ||= Comment.new
  end

  private
  def model_must_exist
    if model.nil?
      errors.add(:number, "contrato o activo no existe")
    end
  end

  def assets_present?
    if asset_ids.empty?
      errors.add(:number,
        "no se encontraron activos asociados al contrato a los cuales generar orden de inspección")
    end
  end

  def model
    @model ||= get_model(number, number_from)
  end

  def requestor
    @requestor ||= User.find(requested_by)
  end

  def get_model(number, number_from)
    finder = number_from.eql?('asset') ? "license_plate" : "number"
    number_from.classify.constantize.
      send("find_by_#{finder}", number)
  end

  def asset_ids
    @asset_ids ||=  if model.is_a? Contract
        asset_ids = model.assets.pluck(:id)
      else
        asset_ids = [ model.id ]
      end
  end

  def inspection_order_form_params
    params.require(:inspection_order_form).permit(:requested_by, :number,
                                          :number_from, :recurring,
                                          :renew_period, :note_content,
                                          :priority)
  end
end
