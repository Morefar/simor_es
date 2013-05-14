class ContractsController < ApplicationController
  before_filter :find_contract, except: [:new, :create, :index]

  def find_contract
    @contract = Contract.find_by_id(params[:id])
  end

#CREATE ACTIONS
  def new
    @categories = Category.all
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(params[:contract])
    if @gcontract.save
      redirect_to contracts_url
    else
      render 'new'
    end

  end

#READ ACTIONS
  def index
      @contracts = Contract.all
  end

  def show
  end

#UPDATE ACTIONS
def edit
  @categories = Category.all
end

def update
  @contract.update_attributes(params[:contract])

  if @contract.save
    redirect_to contract_url(contract.id)
  else
    render 'edit'
  end
end

#DELETE ACTIONS
def destroy
  @contract.destroy
  redirect_to contracts_url
end

end
