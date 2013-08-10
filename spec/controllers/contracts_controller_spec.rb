require 'spec_helper'
describe ContractsController do

  describe 'GET #index' do
    it 'populates an array of contracts' do
        contract = create(:contract)
        get :index
        expect(assigns(:contracts)).to match_array [contract]
    end
    it 'populates an array of contracts ordered by creation date' do
      contract1 = create(:contract)
      contract2 = create(:contract)
      get :index
      expect(assigns(:contracts)).to eql [contract2, contract1]
    end
    it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested contract to @contract' do
        contract = create(:contract)
        get :show, id:contract.id
        expect(assigns(:contract)).to eq contract
    end
    it 'renders the :show template' do
        contract = create(:contract)
        get :show, id:contract.id
        expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new Contract to @contract' do
        get :new
        expect(assigns(:contract)).to be_a_new(Contract)
    end
    it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
      it 'assigns the requested contract to @contract' do
        contract = create(:contract)
        get :edit, id: contract
        expect(assigns(:contract)).to eq contract
    end
      it 'renders the :edit template' do
        contract = create(:contract)
        get :edit, id: contract
        expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
        it 'saves the new contract in the database' do
            expect { post :create, contract: (build_attributes :contract) }.to change(Contract, :count).by (1)
        end
        it 'redirects to the :show page'
    end

    context 'with invalid attributes' do
        it 'does not save the new contract in the database'
        it 're-renders the :new template'
    end
  end

  describe 'PUT #update' do
      context "with valid attributes" do
          it "updates the contract in the database"
          it "redirects to the contract"
      end
      context "with invalid attributes" do
          it "does not update the contract"
          it "re-renders the :edit template"
      end
  end

  describe 'DELETE #destroy' do
    it 'deletes the contract from the database'
    it 'redirects to the contracts :index page'
  end

end
