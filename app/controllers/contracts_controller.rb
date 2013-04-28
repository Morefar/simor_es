class ContractsController < ApplicationController

#CREATE ACTIONS
  def new
    @categories = Category.all
  end

  def create

    contract = Contract.new

    contract.number = params[:number]
    contract.category_id = params[:category_id].to_i
    contract.start_date = Date.parse("#{params["contract"]["start_date(1i)"]}-#{params["contract"]["start_date(2i)"]}-#{params["contract"]["start_date(3i)"]}")
    contract.month_duration = params[:month_duration].to_i
    contract.expiration_date = contract.start_date >> contract.month_duration
    contract.total_value = params[:total_value].to_f
    if params[:option_to_buy].eql?('on')
      contract.option_to_buy = params[:option_to_buy]
      contract.last_date_to_option = Date.parse("#{params["contract"]["last_date_to_option(1i)"]}-#{params["contract"]["last_date_to_option(2i)"]}-#{params["contract"]["last_date_to_option(3i)"]}")
    end
    contract.asset_count = params[:asset_count]
    contract.location_of_assets = params[:location_of_assets]

    contract.save

    redirect_to contracts_url
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
  contract.category_id = params[:category_id].to_i
  contract.start_date = Date.parse("#{params["contract"]["start_date(1i)"]}-#{params["contract"]["start_date(2i)"]}-#{params["contract"]["start_date(3i)"]}")
  contract.month_duration = params[:month_duration].to_i
  contract.expiration_date = contract.start_date >> contract.month_duration
  contract.total_value = params[:total_value].to_f
  if params[:option_to_buy].eql?('on')
    contract.option_to_buy = true
    contract.last_date_to_option = Date.parse("#{params["contract"]["last_date_to_option(1i)"]}-#{params["contract"]["last_date_to_option(2i)"]}-#{params["contract"]["last_date_to_option(3i)"]}")
  end
  contract.asset_count = params[:asset_count]
  contract.location_of_assets = params[:location_of_assets]

  contract.save

  redirect_to contract_url(contract.id)
end

#DELETE ACTIONS
def destroy
  contract = Contract.find_by_id(params[:id])
  contract.destroy
  redirect_to contracts_url
end

end
