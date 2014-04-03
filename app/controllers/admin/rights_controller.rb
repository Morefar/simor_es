module Admin
  class RightsController < ApplicationController
    before_action :set_right, only: [:show, :edit, :update, :destroy]

    def index
      authorize(Right)
      @rights = Right.all
    end

    def show
      authorize(@right)
    end

    def new
      authorize(Right)
      @right = Right.new
    end

    def edit
      authorize(@right)
    end

    def create
      authorize(Right)
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

    def update
      authorize(@right)
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

    def destroy
      authorize(@right)
      @right.destroy
      respond_to do |format|
        format.html { redirect_to rights_url }
        format.json { head :no_content }
      end
    end

    private
    def set_right
      @right = Right.find(params[:id])
    end

    def right_params
      params.require(:right).permit(:resource, :operation)
    end
  end
end
