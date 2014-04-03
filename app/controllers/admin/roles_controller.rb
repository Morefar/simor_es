module Admin
  class RolesController < ApplicationController
    before_action :set_role, only: [:show, :edit, :update, :destroy]

    def index
      authorize(Role)
      @roles = Role.all
    end

    def show
      authorize(@role)
    end

    def new
      @role = Role.new
      authorize(@role)
    end

    def edit
      authorize(@role)
    end

    def create
      @role = Role.new(role_params)
      authorize(@role)
      respond_to do |format|
        if @role.save
          format.html { redirect_to @role, notice: 'Role was successfully created.' }
          format.json { render action: 'show', status: :created, location: @role }
        else
          format.html { render action: 'new' }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize(@role)
      respond_to do |format|
        if @role.update(role_params)
          format.html { redirect_to @role, notice: 'Role was successfully updated.' }
          format.json { render action: 'show', status: :ok, location: @role }
        else
          format.html { render action: 'edit' }
          format.json { render json: @role.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize(@role)
      @role.destroy
      respond_to do |format|
        format.html { redirect_to roles_url }
        format.json { head :no_content }
      end
    end

    private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name).
        merge(params.permit(right_ids: []))
    end
  end
end
