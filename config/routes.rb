Rails.application.routes.draw do
  root to: 'characters#index'

  get '/search', to: 'characters#show', as: :search
end
