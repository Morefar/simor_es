class AssetsController < ApplicationController
  before_filter :find_asset, except: [:new, :create, :index]

  def index
    @assets = Asset.includes(:contract, :make, :model).page params[:page]
    add_breadcrumb 'Assets', :assets_path
    respond_to do |format|
      format.html
      format.json do
        if params.has_key? :asset_license_plate
          render json: Asset.where("license_plate =?", params[:asset_license_plate])
                            .pluck(:id)
        else
          render json: Asset.search_license_plate("%#{params[:term]}%")
                            .limit(10).pluck(:license_plate)
        end
      end
    end
  end

  def show
    add_breadcrumb "Contract: #{@asset.contract.number}", @asset.contract
    add_breadcrumb "Asset: #{@asset.inventory_number}", @asset
    respond_to do |format|
      format.html
      format.json { render json: @asset }
      format.js
    end
  end

  def new
    @asset = Asset.new

    respond_to do |format|
      format.html
      format.json { render json: @asset }
    end
  end

  def edit
  end

  def create
    @asset = Asset.new params[:asset]
    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end



  def update
    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end



  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url }
    end
  end

  private
  def find_asset
    @asset = Asset.includes(:make, :model, :color, :kind, :body, :documents, :inspections,
                            contract: [:category, { lessee: :identification_type }],
                           comments: :user)
                            .find_by_id params[:id] if params[:id]
  end
end
