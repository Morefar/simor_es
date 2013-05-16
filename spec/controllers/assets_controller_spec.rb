require 'spec_helper'

describe AssetsController do

  describe 'GET #index' do
    it 'renders the :index view' do

    end

    it 'populates an array of assets' do
      asset = create(:asset)
      get :index
      expect(assigns(:assets)).to match_array [asset]
    end
  end

  describe 'GET #show' do
    it 'renders the :show view'
    it 'populates a single asset'
  end
end
