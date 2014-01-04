class ContractsController < ApplicationController
  before_filter :find_contract, except: [:new, :create, :index]
  before_filter :get_categories, only: [:new, :create, :edit, :update]

#CREATE ACTIONS
  def new
    @contract = Contract.new
    respond_to do |format|
      format.html
      format.json { render json: @contract }
    end
  end

  def create
    @contract = Contract.new(params[:contract])
    if @contract.save
      redirect_to contracts_url
    else
      render 'new'
    end
  end

#READ ACTIONS
  def index
    add_breadcrumb 'Contracts', :contracts_path
    @contracts = Contract.includes(:category, :lessee).page params[:page]
    respond_to do |format|
      format.html
      format.json do
        if params.has_key? :number
          render json: Contract.where("number = ?", params[:number]).pluck(:id)
        else
          render json: Contract.search_number("%#{params[:term]}%")
                                           .limit(10).pluck(:number)
        end
      end
    end
  end

  def show
    add_breadcrumb "Contract:#{@contract.number}", @contract
    @lessee = @contract.lessee
    @cosigners = Array(@contract.cosigners)
    respond_to do |format|
      format.html
      format.js
    end
  end

#UPDATE ACTIONS
  def edit
  end

  def update
    @contract.update_attributes(params[:contract])
    if @contract.save
      redirect_to @contract
    else
      render 'edit'
    end
  end

#DELETE ACTIONS
  def destroy
    @contract.destroy
    redirect_to contracts_url
  end

  private
  def find_contract
    @contract = Contract.includes(:documents, :lessee, comments: :user,
                                  cosigners: {entity: :identification_type},
                                  assets: [:make, :model])
        .find_by_id(params[:id]) if params[:id]
  end
  def get_categories
      @categories = Category.all
  end
end
