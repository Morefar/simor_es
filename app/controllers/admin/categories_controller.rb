module Admin
  class CategoriesController < ApplicationController

    #CREATE ACTIONS
    def new
      authorize(Category)
      @categories = Category.all
      @category = Category.new
    end

    def create
      authorize(Category)
      @category = Category.new(category_params)
      if @category.save
        redirect_to categories_url
      else
        @categories = Category.all
        render 'new'
      end
    end
    #READ ACTIONS
    def index
      authorize(Category)
      @categories = Category.order(:name)
    end
    #EDIT ACTIONS
    def edit
      authorize(Category)
      @category = Category.find_by_id(params[:id])
    end

    def update
      authorize(Category)
      @category = Category.find_by_id(params[:id])
      @category = update_attributes(category_params)
      @caegory.save
      redirect_to categories_url
    end
    #DESTROY ACTIONS
    def destroy
      authorize(Category)
      @category = Category.find_by_id(params[:id])
      @category.destroy
      redirect_to categories_url
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
