Simor::Application.routes.draw do
  scope '(:locale)' do
    devise_for :users
    authenticated do
    resources :comments, only: [:create, :update, :edit]
    resources :entities
    resources :documents, except: [:index]
    end
  end
end
