require 'rails_helper'

describe EntitiesController do
  let(:valid_attributes) { {} }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it "populates an array of entities" do
      entity = create(:entity)
      get :index
      expect(assigns(:entities)).to match_array [entity]
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested entity to @entity" do
      entity = create(:entity)
      get :show, id: entity
      expect(assigns(:entity)).to eq entity
    end
    it "renders the :show template" do
      entity = create(:entity)
      get :show, id: entity
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new entity to @entity" do
      get :new
      expect(assigns(:entity)).to be_a_new(Entity)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested entity to @entity" do
      entity = create(:entity)
      get :edit, id: entity
      expect(assigns(:entity)).to eq entity
    end
    it "renders the :edit template" do
      entity = create(:entity)
      get :edit, id: entity
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "With valid attributes" do
      it "saves the new entity to the database" do
        identification_type_id = create(:identification_type).id
        expect {
          post :create, entity: attributes_for(:entity).merge(identification_type_id: identification_type_id )
        }.to change(Entity, :count).by(1)
      end
      it "redirects to the entity index page" do
        identification_type_id = create(:identification_type).id
        post :create, entity: attributes_for(:entity).merge(identification_type_id: identification_type_id )
        expect(response).to redirect_to entities_url
      end
    end
    context "with invalid attributes" do
      it "does not save the new entity in the database" do
        expect {
          post :create, entity: attributes_for(:invalid_entity)
        }.to_not change(Entity, :count)
      end
      it "re-renders the :new template" do
        post :create, entity: attributes_for(:invalid_entity)
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do

    before :each do
      @identification_type = create(:identification_type, name: 'CC')
      @entity = create(:entity, name: 'Juan Paplo Restrepo', identification_type_id: @identification_type.id, email: 'jprestrepo@example.com')
    end

    it "locates the requested @entity" do
      put :update, id: @entity, entity: attributes_for(:entity).merge(identification_type_id: @identification_type.id)
      expect(assigns(:entity)).to eq @entity
    end

    context "valid attributes" do
      it 'changes @entity\'s attributes' do
        put :update, id: @entity, entity: attributes_for(:entity, name: 'Fernando Melo Inc.').merge(identification_type_id: @identification_type.id)
        @entity.reload
        expect(@entity.name).to redirect_to @entity
      end
      it "redirects to the updated entity" do
        put :update, id: @entity, entity: attributes_for(:entity, name: 'Fernando Melo Inc.').merge(identification_type_id: @identification_type.id)
        expect(response).to redirect_to @entity
      end
    end

    context 'invalid attributes' do
      it "does not change @entity's attributes" do
        put :update, id: @entity, entity: attributes_for(:entity, name: 'None of your business', email: nil)
        @entity.reload
        expect(@entity.name).to_not eq('None of your business')
      end
      it 're-renders the edit method' do
        put :update, id: @entity, entity: attributes_for(:invalid_entity)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @entity = creat       e(:entity)
    end
    it "deletes the entity" do
      expect{
        delete :destroy, id: @entity
      }.to change(Entity, :count).by(-1)
    end
    it "redirects to entities#index" do
      delete :destroy, id: @entity
      expect(response).to redirect_to entities_url
    end
  end
end
