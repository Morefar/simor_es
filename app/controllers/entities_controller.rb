class EntitiesController < ApplicationController
  before_action :find_entity, except: [:index, :new, :create]

def index
  @entities = Entity.includes(:identification_type).order(:name).page params[:page]
  respond_to do |format|
    format.html
    format.json { render json: Entity.search_name("%#{params[:term]}%").limit(10).pluck(:name) }
  end
end

def show
end

def new
  @entity = Entity.new
end

def edit
end

def create
  @entity = Entity.new(entity_params)
  if @entity.save
    redirect_to entities_url
  else
    render 'new'
  end
end

def update
  if @entity.update_attributes(entity_params)
    redirect_to @entity
  else
    render 'edit'
  end
end

def destroy
  @entity.destroy
  redirect_to entities_url
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
