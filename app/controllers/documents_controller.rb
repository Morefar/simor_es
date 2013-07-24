class DocumentsController < ApplicationController
  before_filter :find_document, except: [:new, :create]

  def new
    @document = Document.new
  end

  def show

  end

  def create
    @document = Document.new(params[:document])
    if @document.save
      redirect_to @document.documentable, notice: 'Document was succesfully created.'
    else
      redirect_to @document.documentable, notice: 'Document could not be uploaded'
    end
  end

  def edit

  end

  def update
    if @document.update_attributes(params[:document])
      redirect_to @document.documentable, notice: "Document was successfully created."
    else
      render 'edit'
    end
  end

  def destroy
    docummentable = @document.docummentable
    @document.destroy
    redirect_to docummentable
  end

  private
  def find_document
    @document = Document.find(params[:id]) if params[:id]
  end
end
