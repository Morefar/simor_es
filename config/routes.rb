Simor::Application.routes.draw do
  scope '(:locale)' do
    devise_for :users
    authenticated do
      get '/', to: "dashboard#show", as: :user_root
    end
    authenticate do
      resource :dashboardi, only: [:show]
      resources :contracts, :assets, :categories, :makes, :models, :colors, :kinds, :bodies, :builds, :inspections, :inspection_orders, :insurance_companies
      resources :comments, only: [:create, :update, :edit]
      resources :entities
      resources :documents, except: [:index]
    end
    root to: 'pages#landing'
  end
end
