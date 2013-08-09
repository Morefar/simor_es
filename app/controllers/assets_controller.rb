class AssetsController < ApplicationController
  before_filter :find_asset, except: [:new, :create, :index]

  def index
    @assets = Asset.all
    add_breadcrumb 'Assets', :assets_path
    respond_to do |format|
      format.html
      format.json { render json: @assets }
    end
  end



  def show
    add_breadcrumb "Contract: #{@asset.contract.number}", @asset.contract
    add_breadcrumb "Asset: #{@asset.inventory_number}", @asset
    respond_to do |format|
      format.html
      format.json { render json: @asset }
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
    @asset = Asset.new
    @asset.make = Make.find_by_name(params[:asset][:make_id])
    @asset.model = Model.find_by_name(params[:asset][:model_id])
    @asset.color = Color.find_by_name(params[:asset][:color_id])
    @asset.kind = Color.find_by_name(params[:asset][:kind_id])
    @asset.body = Color.find_by_name(params[:asset][:body_id])
    @asset.attributes = params[:asset].except(:make_id, :model_id,
                                  :color_id, :kind_id, :body_id, :transit_permit)

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
    @asset = Asset.find_by_id params[:id] if params[:id]
  end
end
