class InspectionOrderForm < FormObject::Base
  attribute :contract_number, String
  attribute :user_id, Integer
  attribute :inspection_order, InspectionOrder, default: InspectionOrder.new
  attribute :lessee, Entity, default: Entity.new
  attribute :note, Comment, default: Comment.new
  attribute :document, Document, default: Document.new

  delegate :recurring, :renew_period, :status, :asset_id, :scheduled_date,
    to: :inspection_order
  delegate :name, :identification_number, :identification_type_id, :address, :city,
    :state, to: :lessee
  delegate :content, to: :note, prefix: true
  delegate :content, to: :document, prefix: true

  def submit(params)
    lessee.assign_attributes params.slice(:name, :address, :city, :state,
                                    :identification_number, :identification_type_id)
    note.assign_attributes content: params[:note_content], user_id: params[:user_id]
    document.assign_attributes content: params.slice(:document_content)
    return false unless valid?
    p "valid"
    InspectionOrder.transaction do
      lessee.save!
      inspection_order.save!
      note.save!
    end
  end

  def valid?
    lessee.valid? && note.valid? && document.valid? && inspection_order.valid?
  end

  def inspection_order
    @inspection_order ||= InspectionOrder.new
  end

  def lessee
    @lessee ||= Entity.new
  end

  def note
    @note ||= Comment.new
  end

  def document
    @document ||= Document.new
  end

  def inspection_order_form_params
    params.require(:inspection_order_form).permit(:contract_number, :user_id,
                                                 :name, :address,
                                                 :city, :identification_number,
                                                 :identification_type_id,
                                                 :note_content, :document_content)
  end
end
