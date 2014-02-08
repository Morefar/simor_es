class InspectionsController < ApplicationController
  before_action :find_inspection, except: [:new, :create, :index]


  def index
    @inspections = Inspection.includes(:asset).page params[:page]
    add_breadcrumb "Inspections", :inspections_path
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspections }
    end
  end

  def show
    add_breadcrumb "Contract: #{@inspection.contract.number}", @inspection.contract
    add_breadcrumb "Asset: #{@inspection.asset.inventory_number}", @inspection.asset
    add_breadcrumb "Inspection: #{@inspection.inspection_number}" , @inspection
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspection }
    end
  end

  def new
    @inspection = Inspection.new
    @inspection.asset_license_plate = params[:asset] if params.has_key? :asset
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inspection }
    end
  end

  def edit
  end

  def create
    @inspection = Inspection.new(params[:inspection])
    respond_to do |format|
      if @inspection.save
        format.html { redirect_to @inspection, notice: 'Inspection was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @inspection.update_attributes(params[:inspection])
        format.html { redirect_to @inspection, notice: 'Inspection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inspection.destroy
    respond_to do |format|
      format.html { redirect_to inspections_url }
      format.json { head :no_content }
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
             :asset_license_plate, :modifications)
  end
end
