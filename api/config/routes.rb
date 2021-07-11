Rails.application.routes.draw do

  # Devise actions
  #----------------------------------------------------------------------
  devise_for :users

  # API Endpoints
  #----------------------------------------------------------------------
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do

      resources :user_authentication, only: [:create]
      resources :test, only: [:index]

    end
  end

end
