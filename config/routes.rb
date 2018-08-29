Rails.application.routes.draw do
  root 'manuals#index'

  get '/about', to: "manuals#about", as: :about

  resources :manuals do
    collection do
      get :list, as: :list
    end
  end
end
