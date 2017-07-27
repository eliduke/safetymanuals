Rails.application.routes.draw do
  root 'manuals#index'

  resources :manuals
end
