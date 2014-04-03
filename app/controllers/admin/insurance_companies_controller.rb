module Admin
  class InsuranceCompaniesController < ApplicationController

    before_action :find_insurance_company, except: [:index, :new, :create]

    def index
      authorize(InsuranceCompany)
      @insurance_companies = InsuranceCompany.order(:name).page params[:page]
    end

    def show
      authorize(@insurance_company)
    end

    def new
      authorize(InsuranceCompany)
      @insurance_company = InsuranceCompany.new
    end

    def edit
      authorize(@insurance_company)
    end

    def create
      authorize(InsuranceCompany)
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
      authorize(@insurance_company)
      respond_to do |format|
        if @insurance_company.update_attributes(params[:insurance_company])
          format.html { redirect_to @insurance_company, notice: 'Insurance company was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      authorize(@insurance_company)
      @insurance_company.destroy
      respond_to do |format|
        format.html { redirect_to insurance_companies_url }
      end
    end

    private
    def find_insurance_company
      @insurance_company = InsuranceCompany.find(params[:id]) unless params.fetch(:id).nil?
    end
    def insurance_company_params
      params.require(:insurance_company).permit(:name, :nit)
    end
  end
end
