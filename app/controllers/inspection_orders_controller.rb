class InspectionOrdersController < ApplicationController
  respond_to :html
  before_action :set_inspection_order, only: [:show, :edit, :update, :destroy]

  def index
    @inspection_orders = InspectionOrder.page params[:page]
    respond_with @inspection_orders
  end

  def show
    respond_with @inspection_order
  end

  def new
    @inspection_order_form = InspectionOrderForm.new
    respond_with @inspection_order_form
  end

  def edit
  end

  def create
    @inspection_order_form = InspectionOrderForm.new
    binding.pry
    if @inspection_order_form.submit(inspection_order_form_params)
      respond_with inspection_order_form.inspection_order
    else
      render 'new'
    end
  end

  def update
    @inspection_order.update(inspection_order_params)
    respond_with @inspection_order
  end

  def destroy
    @inspection_order.destroy
    respond_with @inspection_order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection_order
      @inspection_order = InspectionOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_order_params
      params[:inspection_order]
    end

  def inspection_order_form_params
    params.require(:inspection_order_form).permit(:contract_number, :user_id,
                                                 :name, :address,
                                                 :city, :identification_number,
                                                 :identification_type_id,
                                                 :note_content, :document_content)
  end
end
