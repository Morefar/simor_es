class MakesController < ApplicationController
  before_action :find_make, except: [:index, :new, :create]

  def index
    @makes = Make.order(:name).page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: Make.search_name("%#{params[:term]}%").order(:name).limit(10).pluck(:name) }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @make }
    end
  end

  def new
    @make = Make.new
    respond_to do |format|
      format.html
      format.json { render json: @make }
    end
  end

  def edit
  end

  def create
    @make = Make.new(make_params)
    respond_to do |format|
      if @make.save
        format.html { redirect_to @make, notice: 'Make was successfully created.' }
        format.json { render json: @make, status: :created, location: @make }
      else
        format.html { render action: "new" }
        format.json { render json: @make.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @make.update_attributes(make_params)
        format.html { redirect_to @make, notice: 'Make was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @make.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @make.destroy
    respond_to do |format|
      format.html { redirect_to makes_url }
      format.json { head :no_content }
    end
  end

  private
  def find_make
    @make = Make.find(params[:id])
  end
  def make_params
    params.require(:make).permit(:name, :runt_code)
  end
end
