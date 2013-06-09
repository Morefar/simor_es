class ModelsController < ApplicationController


  def index
    @models = Model.all

    respond_to do |format|
      format.html
      format.json { render json: @models }
    end
  end



  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @model }
    end
  end



  def new
    @model = Model.new

    respond_to do |format|
      format.html
      format.json { render json: @model }
    end
  end


  def edit
    @model = Model.find(params[:id])
  end



  def create
    @model = Model.new(params[:model])

    respond_to do |format|
      if @model.save
        format.html { redirect_to @model, notice: 'Model was successfully created.' }
        format.json { render json: @model, status: :created, location: @model }
      else
        format.html { render action: "new" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end



  def update
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to models_url }
      format.json { head :no_content }
    end
  end
end
