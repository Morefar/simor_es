class AssetsController < ApplicationController

  def index
    @assets = Asset.all
  end

  def show
    @asset = Asset.find_by_id(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def create
    # @asset = Asset.new
    @asset.inventory_number = params[:inventory_number]
    @asset.invoice_number = params[:invoice_number]
    @asset.value = params[:value]
    @asset.invoice_date = params[:invoice_date]
    @asset.description = params[:description]
    @asset.scanned_invoice = params[:scanned_invoice]
    @asset.contract_id = params[:contract_id]

    if @asset.save
            redirect_to assets_url
          else
      render 'new'
    end
  end

  def edit
    @asset = Asset.find_by_id(params[:id])
  end

  def update
    @asset = Asset.find_by_id(params[:id])
    @asset.inventory_number = params[:inventory_number]
    @asset.invoice_number = params[:invoice_number]
    @asset.value = params[:value]
    @asset.invoice_date = params[:invoice_date]
    @asset.description = params[:description]
    @asset.scanned_invoice = params[:scanned_invoice]
    @asset.contract_id = params[:contract_id]

    if @asset.save
            redirect_to assets_url
          else
      render 'edit'
    end
  end

  def destroy
    @asset = Asset.find_by_id(params[:id])
    @asset.destroy
        redirect_to assets_url
      end
end
