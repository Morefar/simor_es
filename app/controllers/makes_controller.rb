class MakesController < ApplicationController


  def index
    @makes = Make.all

    respond_to do |format|
      format.html
      format.json { render json: Make.search_name("%#{params[:term]}%").order(:name).limit(10).pluck(:name) }
    end
  end



  def show
    @make = Make.find(params[:id])

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
    @make = Make.find(params[:id])
  end



  def create
    @make = Make.new(params[:make])

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
    @make = Make.find(params[:id])

    respond_to do |format|
      if @make.update_attributes(params[:make])
        format.html { redirect_to @make, notice: 'Make was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @make.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @make = Make.find(params[:id])
    @make.destroy

    respond_to do |format|
      format.html { redirect_to makes_url }
      format.json { head :no_content }
    end
  end
end
