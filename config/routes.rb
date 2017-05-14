Rails.application.routes.draw do
  root to: 'characters#index'

  get '/search', to: 'characters#show', as: :search

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post "/characters", to: 'characters#create'
      # resources :characters, only: [:create]
    end
  end
end
