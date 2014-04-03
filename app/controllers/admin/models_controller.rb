module Admin
  class ModelsController < ApplicationController
    before_action :find_model, except: [:index, :new, :create]

    def index
      authorize(Model)
      @models = Model.includes(:make).order(:make_id, :name).page params[:page]
      respond_to do |format|
        format.html
        format.json { render json: Model.search_name("%#{params[:term]}%").order(:name).limit(10).pluck(:name) }
      end
    end

    def show
      authorize(@model)
      respond_to do |format|
        format.html
        format.json { render json: @model }
      end
    end

    def new
      authorize(Model)
      @model = Model.new
      respond_to do |format|
        format.html
        format.json { render json: @model }
      end
    end

    def edit
      authorize(@model)
    end

    def create
      authorize(Model)
      @model = Model.new(model_params)
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
      authorize(@model)
      respond_to do |format|
        if @model.update_attributes(model_params)
          format.html { redirect_to @model, notice: 'Model was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @model.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize(@model)
      @model.destroy
      respond_to do |format|
        format.html { redirect_to models_url }
        format.json { head :no_content }
      end
    end

    private
    def find_model
      @model = Model.find(params[:id]) if params[:id]
    end
    def model_params
      params.require(:model).permit(:make_id, :name)
    end
  end
end
