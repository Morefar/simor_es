class InspectionOrdersController < ApplicationController
  respond_to :html
  before_action :set_inspection_order, only: [:show, :edit, :update, :destroy]

  def index
    if params.has_key? :status
      @inspection_orders = InspectionOrder.send(params[:status]).
        includes(asset: :contract).by_recency.page params[:page]
    else
      @inspection_orders = InspectionOrder.search(params).
        includes(asset: :contract).page params[:page]
    end
    respond_with @inspection_orders
  end

  def show
      authorize(@inspection_order)
      respond_with @inspection_order
  end

  def new
    @inspection_order_form = InspectionOrderForm.new(params.slice(:number, :number_from))
    authorize(@inspection_order_form)
    respond_with @inspection_order_form
  end

  def edit
    authorize(@inspection_order)
    respond_with @inspection_order
  end

  def create
    @inspection_order_form = InspectionOrderForm.new(params[:inspection_order_form])
    authorize(@inspection_order_form)
    if @inspection_order_form.submit
      redirect_to inspection_orders_url, notice: "Ordenes de Inspección Generadas"
    else
      render 'new'
    end
  end

  def update
    authorize(@inspection_order)
    @inspection_order.change_state(inspection_order_params)
    respond_with @inspection_order
  end

  def destroy
    authorize(@inspection_order)
    @inspection_order.destroy
    respond_with @inspection_order
  end

  private
    def set_inspection_order
      @inspection_order = InspectionOrder.find(params[:id])
    end

    def inspection_order_params
      params.require(:inspection_order).
        permit(:status, :scheduled_date, :priority, notes: [:content, :user_id,
                                                            :commentable_id,
                                                            :commentable_type])

    end

  def inspection_order_form_params
    params.require(:inspection_order_form).
      permit(:contract_number, :user_id, :name, :address, :city,
             :identification_number, :identification_type_id, :note_content,
             :document_content)
  end
end
