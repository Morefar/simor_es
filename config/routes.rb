Simor::Application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    authenticated do
      get '/', to: "dashboard#show", as: :user_root
    end
    authenticate do
      resources :contracts, :assets, :inspections, :inspection_orders,
        :entities do
        get 'search', on: :collection
      end
      resources :comments, only: [:create, :update, :edit]
      resources :documents, except: :index

      scope module: 'admin' do
        resources :categories, :makes, :models, :colors, :kinds, :bodies,
          :insurance_companies, :identification_types, :rights, :roles do
          get 'search', on: :collection
        end
      end
    end
    root to: 'pages#landing'
  end
end
