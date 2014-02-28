class InspectionsController < ApplicationController
  respond_to :html
  before_action :find_inspection, except: [:new, :create, :index]

  def index
    @inspections = Inspection.search(params).includes(:asset).page params[:page]
    add_breadcrumb "Inspections", :inspections_path
    respond_with @inspections
  end

  def show
    add_breadcrumb "Contract: #{@inspection.contract.number}", @inspection.contract
    add_breadcrumb "Asset: #{@inspection.asset.inventory_number}", @inspection.asset
    add_breadcrumb "Inspection: #{@inspection.inspection_number}" , @inspection
    authorize(@inspection)
    @inspection = @inspection.decorate
    respond_with @inspection
  end

  def new
    @inspection = Inspection.new
    authorize(@inspection)
    @inspection.asset_license_plate = params[:asset_license_plate] if params.has_key? :asset_license_plate
    @inspection.inspection_order_id = params[:inspection_order] if params.has_key? :inspection_order
    respond_with @inspection
  end

  def edit
  end

  def create
    @inspection = Inspection.new(inspection_params)
    authorize(@inspection)
    flash[:notice] = "La inspección fue guardada exitosamente" if @inspection.save
    respond_with @inspection
    rescue AASM::InvalidTransition
      flash[:alert] = "No se pudo guardar la inspección. Si el estado de la orden es Pendiente o Generada, primero debe Agendarla."
      render 'new'
  end

  def update
    authorize(@inspection)
    flash[:notice] = "Los datos de la inspección fueron actializados" if @inspection.update_attributes(inspection_params)
    respond_with @inspection
  end

  def destroy
    authorize(@inspection)
    if @inspection.destroy
      redirect_to inspections_url, notice: "Inspección eliminada exitosamente"
    else
        flash.now[:alert] = %{ Inspección no fue eliminada porque aún tiene
                               documentos asociados }
        render action: "show", status: :forbidden
    end
  end

private
  def find_inspection
    @inspection = Inspection.includes(:insurance_company, :documents, :contract,
                                      asset: [:make, :model], comments: :user)
                  .find_by_id(params[:id]) if params[:id]
  end
  def inspection_params
    params.require(:inspection).
      permit(:address, :city, :state, :inspection_date, :current_value,
             :appraiser_value, :soat_number,  :soat_begin_date, :soat_finish_date,
             :emissions_certificate, :emissions_begin_date, :emissions_finish_date,
             :maintenance, :repairs, :security, :exterior, :exterior_notes,
             :interior, :interior_notes, :engine, :engine_notes, :accesories,
             :insurance_number, :insurance_company_id, :insured_value, :currency,
             :insurance_start, :insurance_finish, :person_in_charge, :pic_id,
             :pic_job, :inspection_number, :asset_id, :observations, :odometer,
             :asset_license_plate, :modifications, :inspection_order_id,
             :overall_condition)
  end
end
