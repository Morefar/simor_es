require 'spec_helper'

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

describe InspectionsController do

  # This should return the minimal set of attributes required to create a valid
  # Inspection. As you add validations to Inspection, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InspectionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all inspections as @inspections" do
      inspection = Inspection.create! valid_attributes
      get :index, {}, valid_session
      assigns(:inspections).should eq([inspection])
    end
  end

  describe "GET show" do
    it "assigns the requested inspection as @inspection" do
      inspection = Inspection.create! valid_attributes
      get :show, {:id => inspection.to_param}, valid_session
      assigns(:inspection).should eq(inspection)
    end
  end

  describe "GET new" do
    it "assigns a new inspection as @inspection" do
      get :new, {}, valid_session
      assigns(:inspection).should be_a_new(Inspection)
    end
  end

  describe "GET edit" do
    it "assigns the requested inspection as @inspection" do
      inspection = Inspection.create! valid_attributes
      get :edit, {:id => inspection.to_param}, valid_session
      assigns(:inspection).should eq(inspection)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Inspection" do
        expect {
          post :create, {:inspection => valid_attributes}, valid_session
        }.to change(Inspection, :count).by(1)
      end

      it "assigns a newly created inspection as @inspection" do
        post :create, {:inspection => valid_attributes}, valid_session
        assigns(:inspection).should be_a(Inspection)
        assigns(:inspection).should be_persisted
      end

      it "redirects to the created inspection" do
        post :create, {:inspection => valid_attributes}, valid_session
        response.should redirect_to(Inspection.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inspection as @inspection" do
        # Trigger the behavior that occurs when invalid params are submitted
        Inspection.any_instance.stub(:save).and_return(false)
        post :create, {:inspection => {  }}, valid_session
        assigns(:inspection).should be_a_new(Inspection)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Inspection.any_instance.stub(:save).and_return(false)
        post :create, {:inspection => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested inspection" do
        inspection = Inspection.create! valid_attributes
        # Assuming there are no other inspections in the database, this
        # specifies that the Inspection created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Inspection.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => inspection.to_param, :inspection => { "these" => "params" }}, valid_session
      end

      it "assigns the requested inspection as @inspection" do
        inspection = Inspection.create! valid_attributes
        put :update, {:id => inspection.to_param, :inspection => valid_attributes}, valid_session
        assigns(:inspection).should eq(inspection)
      end

      it "redirects to the inspection" do
        inspection = Inspection.create! valid_attributes
        put :update, {:id => inspection.to_param, :inspection => valid_attributes}, valid_session
        response.should redirect_to(inspection)
      end
    end

    describe "with invalid params" do
      it "assigns the inspection as @inspection" do
        inspection = Inspection.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Inspection.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection.to_param, :inspection => {  }}, valid_session
        assigns(:inspection).should eq(inspection)
      end

      it "re-renders the 'edit' template" do
        inspection = Inspection.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Inspection.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection.to_param, :inspection => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested inspection" do
      inspection = Inspection.create! valid_attributes
      expect {
        delete :destroy, {:id => inspection.to_param}, valid_session
      }.to change(Inspection, :count).by(-1)
    end

    it "redirects to the inspections list" do
      inspection = Inspection.create! valid_attributes
      delete :destroy, {:id => inspection.to_param}, valid_session
      response.should redirect_to(inspections_url)
    end
  end

end
