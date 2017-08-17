Rails.application.routes.draw do
  root 'manuals#index'

  get '/about', to: "manuals#about", as: :about

  resources :manuals, only: [:index, :show] do
    collection do
      get :list, as: :list
    end
  end

  namespace :admin do
    resources :manuals, except: [:show]
  end
end
