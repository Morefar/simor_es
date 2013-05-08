Simor::Application.routes.draw do

root to: "contracts#index"
# Routes for the Asset resource:
# CREATE
  get 'assets/new' => 'Assets#new', as: 'new_asset'
  post '/assets/' => 'Assets#create', as: 'assets'
#READ
  get '/assets' => 'Assets#index'
  get '/assets/:id' => 'Assets#show', as:  'asset'
#UPDATE
  get '/assets/:id/edit' => 'Assets#edit', as: 'edit_asset'
  put '/assets/:id/' => 'Assets#update'
#DESTROY
  delete '/assets/:id' => 'Assets#destroy'
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

  # resources :assets

end
