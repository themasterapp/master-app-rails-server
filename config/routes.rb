Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy'
  end
  
  get 'users/settings/change_locale/:locale', to: 'users/settings#change_locale', as: :change_locale

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  resources :recipes, except: :index
  
  get 'home/index', to: 'home#index', path: '/'
  
  get '/recipes', to: redirect('/')

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
