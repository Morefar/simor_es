class ContractsController < ApplicationController
  before_action :find_contract, except: [:new, :create, :index]
  before_action :get_categories, only: [:new, :create, :edit, :update]

#CREATE ACTIONS
  def new
    @contract = Contract.new
    respond_to do |format|
      format.html
      format.json { render json: @contract }
    end
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to @contract
    else
      render 'new'
    end
  end

#READ ACTIONS
  def index
    @contracts = Contract.contract_search(params).includes(:category, :lessee).page params[:page]
    respond_to do |format|
      format.html
      format.json do
        if params.has_key? :number
          render json: Contract.where("number = ?", params[:number]).pluck(:id)
        else
          render json: Contract.search_by_number("%#{params[:term]}%")
                                           .limit(10).pluck(:number)
        end
      end
    end
  end

  def show
    add_breadcrumb "Contract:#{@contract.number}", @contract
    respond_to do |format|
      format.html
      format.js
    end
  end

#UPDATE ACTIONS
  def edit
  end

  def update
    @contract.update_attributes(contract_params)
    if @contract.save
      redirect_to @contract
    else
      render 'edit'
    end
  end

#DELETE ACTIONS
  def destroy
    if @contract.destroy
      redirect_to contracts_url, notice: "Contrato eliminado exitosamente"
    else
        flash.now[:alert] = %{ No se eliminó porque aún tiene activos o
                              documentos asociados }
        render action: "show", status: :forbidden
    end
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
  def contract_params
    params.require(:contract).
      permit(:number, :start_date, :first_canon_date, :expiration_date, :duration,
             :periodicity, :total_value, :currency, :location_of_assets, :client_id,
             :category_id, :option_to_buy, :last_date_to_option, :category,
             :lessee_name, :cosigners_attributes)
  end
end
