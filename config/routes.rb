Simor::Application.routes.draw do
root to: "assets#index"
resources :contracts, :assets, :categories, :makes, :models,
  :colors, :kinds, :bodies, :builds, :comments, :inspections, :inspection_orders
end
