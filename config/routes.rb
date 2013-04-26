Simor::Application.routes.draw do
## CONTRACTS
#CREATE
  get '/contracts/new' => 'Contracts#new'
  post '/contracts/' => 'Contracts#create'
#READ
  get '/contracts' => 'Contracts#index'
  get '/contracts/:id' => 'Contracts#show'
#UPDATE
  get '/contracts/:id/edit' => 'Contracts#edit'
  put '/contracts/:id/' => 'Contracts#update'
#DESTROY
  delete '/contracts/:id' => 'Contracts#destroy'

## CATEGORIES
#CREATE
  get '/categories/new' => 'Categories#new'
  post '/categories/' => 'Categories#create'
#READ
  get '/categories' => 'Categories#index'
#UPDATE
  get '/categories/:id/edit' => 'Categories#edit'
  put '/categories/:id/' => 'Categories#update'
#DESTROY
  delete '/categories/:id' => 'Categories#destroy'

end
