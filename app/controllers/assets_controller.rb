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
    @asset = Asset.find_by_id(params[:id])
  end

  def update
    @asset = Asset.find_by_id(params[:id])
    @asset.update_attributes(params[:asset])
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
