Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :posts
    end
  end
  resources :posts
  devise_for :users, controllers: { sessions: 'users/sessions', confirmations: 'confirmations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
