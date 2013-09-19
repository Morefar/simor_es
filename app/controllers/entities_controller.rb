class EntitiesController < ApplicationController
  before_filter :find_entity, except: [:index, :new, :create]

def index
  @entities = Entity.includes(:identification_type).order(:name).page params[:page]
end

def show
end

def new
  @entity = Entity.new
end

def edit
end

def create
  @entity = Entity.new(params[:entity])
  if @entity.save
    redirect_to entities_url
  else
    render 'new'
  end
end

def update
  if @entity.update_attributes(params[:entity])
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
end
