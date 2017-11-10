Rails.application.routes.draw do
  resources :planets, only: [:index, :show]
end
