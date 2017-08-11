Rails.application.routes.draw do
  root 'manuals#index'

  resources :manuals, only: [:index, :show]

  namespace :admin do
    resources :manuals, except: [:show]
  end
end
