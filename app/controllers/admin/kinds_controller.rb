module Admin
  class KindsController < ApplicationController
    before_action :find_kind, except: [:index, :new, :create]

    def index
      authorize(Kind)
      @kinds = Kind.order(:name).page params[:page]

      respond_to do |format|
        format.html
        format.json { render json: Kind.search_name("%#{params[:term]}%").order(:name).limit(10).pluck(:name) }
      end
    end

    def show
      authorize(@kind)
      respond_to do |format|
        format.html
        format.json { render json: @kind }
      end
    end

    def new
      authorize(Kind)
      @kind = Kind.new
      respond_to do |format|
        format.html
        format.json { render json: @kind }
      end
    end

    def edit
      authorize(@kind)
    end

    def create
      authorize(Kind)
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
      authorize(@kind)
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
      authorize(@kind)
      @kind.destroy
      respond_to do |format|
        format.html { redirect_to kinds_url }
        format.json { head :no_content }
      end
    end

    private
    def find_kind
      @kind = Kind.find_by_id(params[:id]) if params[:id]
    end
    def kind_params
      params.require(:kind).permit(:name)
    end
  end
end
