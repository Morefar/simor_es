Simor::Application.routes.draw do
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
