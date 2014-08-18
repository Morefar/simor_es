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

describe KindsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Kind. As you add validations to Kind, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # KindsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all kinds as @kinds" do
      kind = Kind.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:kinds)).to eq([kind])
    end
  end

  describe "GET show" do
    it "assigns the requested kind as @kind" do
      kind = Kind.create! valid_attributes
      get :show, {:id => kind.to_param}, valid_session
      expect(assigns(:kind)).to eq(kind)
    end
  end

  describe "GET new" do
    it "assigns a new kind as @kind" do
      get :new, {}, valid_session
      expect(assigns(:kind)).to be_a_new(Kind)
    end
  end

  describe "GET edit" do
    it "assigns the requested kind as @kind" do
      kind = Kind.create! valid_attributes
      get :edit, {:id => kind.to_param}, valid_session
      expect(assigns(:kind)).to eq(kind)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Kind" do
        expect {
          post :create, {:kind => valid_attributes}, valid_session
        }.to change(Kind, :count).by(1)
      end

      it "assigns a newly created kind as @kind" do
        post :create, {:kind => valid_attributes}, valid_session
        expect(assigns(:kind)).to be_a(Kind)
        expect(assigns(:kind)).to be_persisted
      end

      it "redirects to the created kind" do
        post :create, {:kind => valid_attributes}, valid_session
        expect(response).to redirect_to(Kind.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kind as @kind" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Kind).to receive(:save).and_return(false)
        post :create, {:kind => { "name" => "invalid value" }}, valid_session
        expect(assigns(:kind)).to be_a_new(Kind)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Kind).to receive(:save).and_return(false)
        post :create, {:kind => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested kind" do
        kind = Kind.create! valid_attributes
        # Assuming there are no other kinds in the database, this
        # specifies that the Kind created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Kind).to receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => kind.to_param, :kind => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested kind as @kind" do
        kind = Kind.create! valid_attributes
        put :update, {:id => kind.to_param, :kind => valid_attributes}, valid_session
        expect(assigns(:kind)).to eq(kind)
      end

      it "redirects to the kind" do
        kind = Kind.create! valid_attributes
        put :update, {:id => kind.to_param, :kind => valid_attributes}, valid_session
        expect(response).to redirect_to(kind)
      end
    end

    describe "with invalid params" do
      it "assigns the kind as @kind" do
        kind = Kind.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Kind).to receive(:save).and_return(false)
        put :update, {:id => kind.to_param, :kind => { "name" => "invalid value" }}, valid_session
        expect(assigns(:kind)).to eq(kind)
      end

      it "re-renders the 'edit' template" do
        kind = Kind.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Kind).to receive(:save).and_return(false)
        put :update, {:id => kind.to_param, :kind => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested kind" do
      kind = Kind.create! valid_attributes
      expect {
        delete :destroy, {:id => kind.to_param}, valid_session
      }.to change(Kind, :count).by(-1)
    end

    it "redirects to the kinds list" do
      kind = Kind.create! valid_attributes
      delete :destroy, {:id => kind.to_param}, valid_session
      expect(response).to redirect_to(kinds_url)
    end
  end

end
