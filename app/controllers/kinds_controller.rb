class KindsController < ApplicationController


  def index
    @kinds = Kind.all

    respond_to do |format|
      format.html
      format.json { render json: @kinds }
    end
  end



  def show
    @kind = Kind.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kind }
    end
  end



  def new
    @kind = Kind.new

    respond_to do |format|
      format.html
      format.json { render json: @kind }
    end
  end


  def edit
    @kind = Kind.find(params[:id])
  end



  def create
    @kind = Kind.new(params[:kind])

    respond_to do |format|
      if @kind.save
        format.html { redirect_to @kind, notice: 'Kind was successfully created.' }
        format.json { render json: @kind, status: :created, location: @kind }
      else
        format.html { render action: "new" }
        format.json { render json: @kind.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    @kind = Kind.find(params[:id])

    respond_to do |format|
      if @kind.update_attributes(params[:kind])
        format.html { redirect_to @kind, notice: 'Kind was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kind.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @kind = Kind.find(params[:id])
    @kind.destroy

    respond_to do |format|
      format.html { redirect_to kinds_url }
      format.json { head :no_content }
    end
  end
end
