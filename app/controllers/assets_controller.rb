class AssetsController < ApplicationController
  before_filter :find_asset :except [:new, :create, :index]

  def find_asset
    @asset = Asset.find_by_id(params[:id])
  end

  def index
    @assets = Asset.all
  end

  def show
  end

  def new
    @asset = Asset.new
    @asset.contract = Contract.find_by_id(session[:contract_id])
  end

  def create
    asset = Asset.new(params[:asset])
    asset.licence_plate.upcase!
    asset.chassis_number.upcase!
    asset.motor_number.upcase!
    if asset.save
      redirect_to assets_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @asset.update_attributes(params[:asset])
    if @asset.save
            redirect_to assets_url
          else
      render 'edit'
    end
  end

  def destroy
    @asset.destroy
    redirect_to assets_url
  end
end
