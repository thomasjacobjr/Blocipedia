Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:destroy]
  end

  resources :charges, only: [:new, :create, :destroy]

  devise_for :users

  root "welcome#index"

end
