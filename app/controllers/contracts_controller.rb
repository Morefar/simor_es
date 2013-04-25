class ContractsController < ApplicationController

#CREATE ACTIONS
  def new
    @categories = Category.all
  end

  def create

    contract = Contract.new

    contract.number = params[:number]
    contract.category_id = params[:category_id].to_i
    contract.start_date = Date.parse(params[:start_date])
    contract.month_duration = params[:month_duration].to_i
    contract.expiration_date = Date.parse(params[:start_date]) >> contract.month_duration
    contract.total_value = params[:total_value].to_f
    if params[:option_to_buy].eql?('on')
      contract.option_to_buy = params[:option_to_buy]
      contract.last_date_to_option = Date.parse(params[:last_date_to_option])
    end
    contract.asset_count = params[:asset_count]
    contract.location_of_assets = params[:location_of_assets]

    contract.save

    redirect_to '/contracts'
  end

#READ ACTIONS
  def index
      @contracts = Contract.all
  end

  def show
    #TODO get contract info and send it to the view.
    @contract = Contract.find_by_id(params[:id])
  end

#UPDATE ACTIONS
def edit
  # TODO get contract info, fill spaces and send to the view.
  @contract = Contract.find_by_id(params[:id])
  @categories = Category.all
end

def update
  #TODO update database record with the contract info.
  contract = Contract.find_by_id(params[:id])

  contract.number = params[:number]
  contract.category_id = Category.find(params[:category_id])
  contract.start_date = Date.parse(params[:start_date])
  contract.month_duration = params[:month_duration].to_i
  contract.expiration_date = Date.parse(params[:start_date]) >> contract.month_duration
  contract.total_value = params[:total_value].to_f
  if params[:option_to_buy].eql?('on')
    contract.option_to_buy = true
    contract.last_date_to_option = Date.parse(params[:last_date_to_option])
  end
  contract.asset_count = params[:asset_count]
  contract.location_of_assets = params[:location_of_assets]

  contract.save

  redirect_to "/contracts/#{contract.id}"
end

#DELETE ACTIONS
def destroy
  contract = Contract.find_by_id(params[:id])
  contract.destroy
  redirect_to '/contracts'
end

end
