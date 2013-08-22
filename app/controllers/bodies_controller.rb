class BodiesController < ApplicationController


  def index
    @bodies = Body.all

    respond_to do |format|
      format.html
      format.json { render json: Body.search_name("%#{params[:term]}%").order(:name).limit(10).pluck(:name) }
    end
  end



  def show
    @body = Body.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @body }
    end
  end



  def new
    @body = Body.new

    respond_to do |format|
      format.html
      format.json { render json: @body }
    end
  end


  def edit
    @body = Body.find(params[:id])
  end



  def create
    @body = Body.new(params[:body])

    respond_to do |format|
      if @body.save
        format.html { redirect_to @body, notice: 'Body was successfully created.' }
        format.json { render json: @body, status: :created, location: @body }
      else
        format.html { render action: "new" }
        format.json { render json: @body.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    @body = Body.find(params[:id])

    respond_to do |format|
      if @body.update_attributes(params[:body])
        format.html { redirect_to @body, notice: 'Body was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @body = Body.find(params[:id])
    @body.destroy

    respond_to do |format|
      format.html { redirect_to bodies_url }
      format.json { head :no_content }
    end
  end
end
