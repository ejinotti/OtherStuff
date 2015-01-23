Rails.application.routes.draw do
  root to: "root#root"

  resources :posts, only: [:index, :create, :update, :destroy, :show]
end
