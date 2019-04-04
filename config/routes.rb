Rails.application.routes.draw do
  get '/login'      => 'sessions#new'
  post '/login'     => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  get '/signup'     => 'users#new'
  post '/signup'    => 'users#create'
  get '/home'       => 'static_pages#home'
  get '/help'       => 'static_pages#help'
  get '/about'      => 'static_pages#about'
  get '/contact'    => 'static_pages#contact' 

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
end
