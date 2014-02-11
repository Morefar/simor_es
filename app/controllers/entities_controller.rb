class EntitiesController < ApplicationController
  respond_to :html
  before_action :find_entity, except: [:index, :new, :create]

def index
  @entities = Entity.includes(:identification_type).order(:name).page params[:page]
  respond_to do |format|
    format.html
    format.json { render json: Entity.search_name("%#{params[:term]}%").limit(10).pluck(:name) }
  end
end

def show
  respond_with @entity
end

def new
  @entity = Entity.new
  respond_with @entity
end

def edit
end

def create
  @entity = Entity.new(entity_params)
  flash[:notice] = "Persona creada satisfactoriamente" if @entity.save
  respond_with @entity
end

def update
  flash[:notice] = "Datos de persona actualizados" if @entity.update_attributes(entity_params)
  respond_with @entity
end

def destroy
    if @entity.destroy
      redirect_to entities_url, notice: "Datos de Persona eliminados exitosamente"
    else
        flash.now[:alert] = %{ Datos de persona no fueron eliminados porque aún tiene
                               contratos asociados }
        render action: "show", status: :forbidden
    end
end

private
  def find_entity
    @entity = Entity.find(params[:id]) if params[:id]
  end

  def entity_params
    params.require(:entity).
      permit(:address, :city, :email, :identification_type_id,
             :identification_number,:mobile_phone, :name, :phone, :state)
  end
end
