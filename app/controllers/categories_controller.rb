class CategoriesController < ApplicationController

#CREATE ACTIONS
  def new
    @categories = Category.all
  end

  def create
    cat = Category.new
    cat.name = params[:name]
    cat.save
    redirect_to categories_url
  end
#READ ACTIONS
  def index
    @categories = Category.all
  end
#EDIT ACTIONS
  def edit
    @category = Category.find(params[:id])
  end

  def update
    cat = Category.find(params[:id])
    cat.name = params[:name]
    cat.save
    redirect_to categories_url
  end
#DESTROY ACTIONS
  def destroy
    cat = Category.find(params[:id])
    cat.destroy
    redirect_to categories_url
  end

end
