Simor::Application.routes.draw do
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
end
