class AssetsController < ApplicationController
  before_action :find_asset, except: [:new, :create, :index]

  def index
    @assets = Asset.search(params).includes(:contract, :make, :model).page params[:page]
    add_breadcrumb 'Assets', :assets_path
    respond_to do |format|
      format.html
      format.json do
        if params.has_key? :asset_license_plate
          render json: Asset.where("license_plate =?", params[:asset_license_plate])
                            .pluck(:id)
        else
          render json: Asset.search(query: "#{params[:term]}", options: :by_license_plate)
                            .limit(10).pluck(:license_plate)
        end
      end
    end
  end

  def show
    add_breadcrumb "Contract: #{@asset.contract_number}", @asset.contract
    add_breadcrumb "Asset: #{@asset.inventory_number}", @asset
    @asset = @asset.decorate
    respond_to do |format|
      format.html
      format.json { render json: @asset }
      format.js
    end
  end

  def new
    @asset = Asset.new
    @asset.contract_number = params[:contract] if params.has_key? :contract
    respond_to do |format|
      format.html
      format.json { render json: @asset }
    end
  end

  def edit
  end

  def create
    @asset = Asset.new(asset_params)
    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Activo creado exitosamente.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @asset.update_attributes(asset_params)
        format.html { redirect_to @asset, notice: 'Activo actualizado correctamente' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    if @asset.destroy
      redirect_to assets_url, notice: "Activo eliminado exitosamente"
    else
        flash.now[:alert] = %{ Activo no fue eliminado porque aún tiene
                              inspecciones o documentos asociados }
        render action: "show", status: :forbidden
    end
  end

  private
  def find_asset
    @asset = Asset.includes(:make, :model, :color, :kind, :body, :documents, :inspections,
                            contract: [:category, { lessee: :identification_type }],
                           comments: :user)
                            .find_by_id params[:id] if params[:id]
  end

  def asset_params
    params.require(:asset).
      permit(:invoice_id, :inventory_number, :license_plate, :make_name,
    :model_name, :year, :cylinder_cap, :color_name, :service_type, :kind_name,
    :body_name, :fuel_type, :capacity, :motor_number, :rerecorded_motor, :vin,
    :serial_number, :rerecorded_serial, :chassis_number, :rerecorded_chassis,
    :mobility_restriction, :shield_level, :horse_power, :importd_assembld,
    :import_statement, :color_id, :import_date, :number_of_doors, :property_limitation,
    :registration_date, :tp_issue_date, :tp_expiration_date, :transit_authority,
    :book_value, :last_inspection_date, :contract_number, :transit_permit, :color,
    :make, :model, :body, :kind, :contract)
  end
end
