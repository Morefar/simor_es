Simor::Application.routes.draw do
  scope '(:locale)' do
    root to: "assets#index"
    resources :contracts, :assets, :categories, :makes, :models, :colors, :kinds, :bodies, :builds, :inspections, :inspection_orders, :insurance_companies
    resources :comments, only: [:create, :update, :edit]
    resources :entities
    resources :documents, except: [:index]
  end
end
