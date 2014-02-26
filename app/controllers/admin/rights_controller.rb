class Admin::RightsController < ApplicationController
  before_action :set_right, only: [:show, :edit, :update, :destroy]

  # GET /admin/rights
  # GET /admin/rights.json
  def index
    @rights = Right.all
  end

  # GET /admin/rights/1
  # GET /admin/rights/1.json
  def show
  end

  # GET /admin/rights/new
  def new
    @right = Right.new
  end

  # GET /admin/rights/1/edit
  def edit
  end

  # POST /admin/rights
  # POST /admin/rights.json
  def create
    @right = Right.new(right_params)

    respond_to do |format|
      if @right.save
        format.html { redirect_to :index, notice: 'Right was successfully created.' }
        format.json { render action: 'show', status: :created, location: @right }
      else
        format.html { render action: 'new' }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/rights/1
  # PATCH/PUT /admin/rights/1.json
  def update
    respond_to do |format|
      if @right.update(right_params)
        format.html { redirect_to action: 'index', notice: 'Right was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @right }
      else
        format.html { render action: 'edit' }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/rights/1
  # DELETE /admin/rights/1.json
  def destroy
    @right.destroy
    respond_to do |format|
      format.html { redirect_to rights_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_right
      @right = Right.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def right_params
      params.require(:right).permit(:resource, :operation)
    end
end
