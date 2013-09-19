class CategoriesController < ApplicationController

#CREATE ACTIONS
  def new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_url
    else
      @categories = Category.all
      render 'new'
    end
  end
#READ ACTIONS
  def index
    @categories = Category.order(:name)
  end
#EDIT ACTIONS
  def edit
    @category = Category.find_by_id(params[:id])
  end

  def update
    @category = Category.find_by_id(params[:id])
    @category = update_attributes(params[:category])
    @caegory.save
    redirect_to categories_url
  end
#DESTROY ACTIONS
  def destroy
    @category = Category.find_by_id(params[:id])
    @category.destroy
    redirect_to categories_url
  end
end
