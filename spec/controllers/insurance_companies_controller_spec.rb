require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe InsuranceCompaniesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # InsuranceCompany. As you add validations to InsuranceCompany, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InsuranceCompaniesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all insurance_companies as @insurance_companies" do
      insurance_company = InsuranceCompany.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:insurance_companies)).to eq([insurance_company])
    end
  end

  describe "GET show" do
    it "assigns the requested insurance_company as @insurance_company" do
      insurance_company = InsuranceCompany.create! valid_attributes
      get :show, {:id => insurance_company.to_param}, valid_session
      expect(assigns(:insurance_company)).to eq(insurance_company)
    end
  end

  describe "GET new" do
    it "assigns a new insurance_company as @insurance_company" do
      get :new, {}, valid_session
      expect(assigns(:insurance_company)).to be_a_new(InsuranceCompany)
    end
  end

  describe "GET edit" do
    it "assigns the requested insurance_company as @insurance_company" do
      insurance_company = InsuranceCompany.create! valid_attributes
      get :edit, {:id => insurance_company.to_param}, valid_session
      expect(assigns(:insurance_company)).to eq(insurance_company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new InsuranceCompany" do
        expect {
          post :create, {:insurance_company => valid_attributes}, valid_session
        }.to change(InsuranceCompany, :count).by(1)
      end

      it "assigns a newly created insurance_company as @insurance_company" do
        post :create, {:insurance_company => valid_attributes}, valid_session
        expect(assigns(:insurance_company)).to be_a(InsuranceCompany)
        expect(assigns(:insurance_company)).to be_persisted
      end

      it "redirects to the created insurance_company" do
        post :create, {:insurance_company => valid_attributes}, valid_session
        expect(response).to redirect_to(InsuranceCompany.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved insurance_company as @insurance_company" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(InsuranceCompany).to receive(:save).and_return(false)
        post :create, {:insurance_company => {  }}, valid_session
        expect(assigns(:insurance_company)).to be_a_new(InsuranceCompany)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(InsuranceCompany).to receive(:save).and_return(false)
        post :create, {:insurance_company => {  }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested insurance_company" do
        insurance_company = InsuranceCompany.create! valid_attributes
        # Assuming there are no other insurance_companies in the database, this
        # specifies that the InsuranceCompany created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(InsuranceCompany).to receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => insurance_company.to_param, :insurance_company => { "these" => "params" }}, valid_session
      end

      it "assigns the requested insurance_company as @insurance_company" do
        insurance_company = InsuranceCompany.create! valid_attributes
        put :update, {:id => insurance_company.to_param, :insurance_company => valid_attributes}, valid_session
        expect(assigns(:insurance_company)).to eq(insurance_company)
      end

      it "redirects to the insurance_company" do
        insurance_company = InsuranceCompany.create! valid_attributes
        put :update, {:id => insurance_company.to_param, :insurance_company => valid_attributes}, valid_session
        expect(response).to redirect_to(insurance_company)
      end
    end

    describe "with invalid params" do
      it "assigns the insurance_company as @insurance_company" do
        insurance_company = InsuranceCompany.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(InsuranceCompany).to receive(:save).and_return(false)
        put :update, {:id => insurance_company.to_param, :insurance_company => {  }}, valid_session
        expect(assigns(:insurance_company)).to eq(insurance_company)
      end

      it "re-renders the 'edit' template" do
        insurance_company = InsuranceCompany.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(InsuranceCompany).to receive(:save).and_return(false)
        put :update, {:id => insurance_company.to_param, :insurance_company => {  }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested insurance_company" do
      insurance_company = InsuranceCompany.create! valid_attributes
      expect {
        delete :destroy, {:id => insurance_company.to_param}, valid_session
      }.to change(InsuranceCompany, :count).by(-1)
    end

    it "redirects to the insurance_companies list" do
      insurance_company = InsuranceCompany.create! valid_attributes
      delete :destroy, {:id => insurance_company.to_param}, valid_session
      expect(response).to redirect_to(insurance_companies_url)
    end
  end

end
