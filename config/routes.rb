Rails.application.routes.draw do
  root 'manuals#index'

  resources :manuals, only: [:index, :show] do
    collection do
      get :list
    end
  end

  namespace :admin do
    resources :manuals, except: [:show]
  end
end
