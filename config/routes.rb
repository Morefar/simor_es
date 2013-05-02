Simor::Application.routes.draw do
  # Routes for the Asset resource:
  # CREATE

  root to: "contracts#index"

  get '/assets/new', controller: 'assets', action: 'new', as: 'new_asset'
  get '/assets/new/:id', controller: 'assets', action: 'new', as: 'new_asset_from_parent'
  post '/assets', controller: 'assets', action: 'create'

  # READ
  get '/assets', controller: 'assets', action: 'index', as: 'assets'
  get '/assets/:id', controller: 'assets', action: 'show', as: 'asset'

  # UPDATE
  get '/assets/:id/edit', controller: 'assets', action: 'edit', as: 'edit_asset'
  put '/assets/:id', controller: 'assets', action: 'update'

  # DELETE
  delete '/assets/:id', controller: 'assets', action: 'destroy'
  #------------------------------

## CONTRACTS
#CREATE
  get '/contracts/new' => 'Contracts#new', :as => "new_contract"
  post '/contracts/' => 'Contracts#create', :as => "contracts"
#READ
  get '/contracts' => 'Contracts#index'
  get '/contracts/:id' => 'Contracts#show', :as => "contract"
#UPDATE
  get '/contracts/:id/edit' => 'Contracts#edit', :as => "edit_contract"
  put '/contracts/:id/' => 'Contracts#update'
#DESTROY
  delete '/contracts/:id' => 'Contracts#destroy'

## CATEGORIES
#CREATE
  get '/categories/new' => 'Categories#new', :as => "new_category"
  post '/categories/' => 'Categories#create', :as => "categories"
#READ
  get '/categories' => 'Categories#index'
#UPDATE
  get '/categories/:id/edit' => 'Categories#edit', :as => "edit_category"
  put '/categories/:id/' => 'Categories#update', :as => "category"
#DESTROY
  delete '/categories/:id' => 'Categories#destroy'

end
