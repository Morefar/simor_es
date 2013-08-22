class InsuranceCompaniesController < ApplicationController

  before_filter :find_insurance_company, except: [:index, :new, :create]

  def index
    @insurance_companies = InsuranceCompany.all
  end

  def show
  end

  def new
    @insurance_company = InsuranceCompany.new
  end

  def edit
  end

  def create
    @insurance_company = InsuranceCompany.new(params[:insurance_company])
    respond_to do |format|
      if @insurance_company.save
        format.html { redirect_to @insurance_company, notice: 'Insurance company was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @insurance_company.update_attributes(params[:insurance_company])
        format.html { redirect_to @insurance_company, notice: 'Insurance company was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @insurance_company.destroy
    respond_to do |format|
      format.html { redirect_to insurance_companies_url }
    end
  end

  private
  def find_insurance_company
    @insurance_company = InsuranceCompany.find(params[:id]) unless params.fetch(:id).nil?
  end
end
