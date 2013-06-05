Simor::Application.routes.draw do
root to: "contracts#index"
resources :contracts, :assets, :categories, :makes, :models,
  :colors, :kinds, :bodies, :builds, :comments
end
