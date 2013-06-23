class InspectionsController < ApplicationController
  before_filter :find_inspection, except: [:new, :create, :index]

  def index
    @inspections = Inspection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspections }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspection }
    end
  end

  def new
    @inspection = Inspection.new

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
        format.json { render json: @inspection, status: :created, location: @inspection }
      else
        format.html { render action: "new" }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
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
    @inspection = Inspection.find_by_id(params[:id])
  end
end
