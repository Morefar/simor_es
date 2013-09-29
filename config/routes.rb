Simor::Application.routes.draw do
  scope '(:locale)' do
    devise_for :users
    authenticated do
      root to: "Dashboard#show"
      resource :dashboard
      resources :contracts, :assets, :categories, :makes, :models, :colors, :kinds, :bodies, :builds, :inspections, :inspection_orders, :insurance_companies
      resources :comments, only: [:create, :update, :edit]
      resources :entities
      resources :documents, except: [:index]
    end
    root to: 'Pages#landing'
  end
end
