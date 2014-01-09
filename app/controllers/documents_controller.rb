class DocumentsController < ApplicationController
  before_action :find_document, except: [:new, :create]

  def new
    @document = Document.new
  end

  def show

  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to @document.documentable, notice: 'Document was succesfully created.'
    else
      redirect_to @document.documentable, alert: 'Document could not be uploaded'
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @document.update_attributes(document_params)
      format.js
      format.html { redirect_to @document.documentable, notice: "Document was successfully updated." }
    else
      render 'edit'
    end
  end

  def destroy
    documentable = @document.documentable
    @document.destroy
    respond_to do |format|
     format.html { redirect_to documentable}
     format.js
    end
  end

  private
  def find_document
    @document = Document.find(params[:id]) if params[:id]
  end

  def document_params
    params.require(:document).
      permit(:category, :content, :slug, :documentable_id, :documentable_type)
  end
end
