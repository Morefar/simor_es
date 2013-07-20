class AssetsController < ApplicationController


  def index
    @assets = Asset.all
    add_breadcrumb 'Assets', :assets_path
    respond_to do |format|
      format.html
      format.json { render json: @assets }
    end
  end



  def show
    @asset = Asset.find(params[:id])
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
    @asset = Asset.find(params[:id])
  end



  def create
    @asset = Asset.new
    @asset.make = Make.find_by_name(params[:asset][:make_id])
    @asset.model = Model.find_by_name(params[:asset][:model_id])
    @asset.color = Color.find_by_name(params[:asset][:color_id])
    @asset.kind = Color.find_by_name(params[:asset][:kind_id])
    @asset.body = Color.find_by_name(params[:asset][:body_id])
    @asset.attributes = params[:asset].except(:make_id, :model_id,
                                  :color_id, :kind_id, :body_id)

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
