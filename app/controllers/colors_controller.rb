class ColorsController < ApplicationController
  before_action :find_color, except: [:index, :new, :create]

  def index
    @colors = Color.order(:name).page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: Color.search_name("%#{params[:term]}%").order(:name).limit(10).pluck(:name) }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @color }
    end
  end

  def new
    @color = Color.new
    respond_to do |format|
      format.html
      format.json { render json: @color }
    end
  end

  def edit
  end

  def create
    @color = Color.new(color_params)
    respond_to do |format|
      if @color.save
        format.html { redirect_to @color, notice: 'Color was successfully created.' }
        format.json { render json: @color, status: :created, location: @color }
      else
        format.html { render action: "new" }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update_attributes(params[:color])
        format.html { redirect_to @color, notice: 'Color was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to colors_url }
      format.json { head :no_content }
    end
  end

  private
  def find_color
    @color = Color.find_by_id(params[:id]) if params[:id]
  end
  def color_params
    params.require(:color).permit(:name)
  end
end
