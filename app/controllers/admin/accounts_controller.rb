module Admin
  class AccountsController < ApplicationController
    respond_to :html
    before_action :find_account, except: [:index, :new, :create]

    def index
      @accounts = Account.all
      respond_with @accounts
    end

    def show
      authorize(@account)
      respond_with @account
    end

    def new
      @account = Account.new
      authorize(@account)
      respond_with @account
    end

    def edit
      authorize(@account)
    end

    def create
      @account = Account.new(account_params)
      authorize(@account)
      flash[:notice] = "Cuenta creada satisfactoriamente" if @entity.save
      respond_with @account
    end

    def update
      authorize(@account)
      flash[:notice] = "Cuenta actualizada" if @account.update_attributes(entity_params)
      respond_with @account
    end

    def destroy
      authorize(@account)
      if @account.destroy
        redirect_to accounts_url, notice: "Cuenta eliminada exitosamente"
      else
        flash.now[:alert] = "Cuenta no pudo ser eliminada"
        render action: "show", status: :forbidden
      end

      private
      def find_account
        @account = Account.find(params[:id]) if params[:id]
      end

      def account_params
        params.require(:account).
          permit(:organization_name, :subdomain)
      end

    end

  end
end
