StolenBicycleRegistry::Application.routes.draw do
  match '/search', to: 'bicycles#index', via: 'get'
  devise_scope :user do
    match 'sign_in', to: 'devise/sessions#new', via: 'get'
    match 'sign_out', to: 'devise/sessions#destroy', via: 'get'
    match 'sign_up', to: 'registrations#new', via: 'get'
  end

  devise_for :users, :controllers => { :registrations => :registrations }

  resources :bicycles
  resources :users, only: [:show]

  match '/home' => 'static_pages#home', via: 'get'
  match '/about' => 'static_pages#about', via: 'get'
  match '/philosophy' => 'static_pages#philosophy', via: 'get'
  match '/faq' => 'static_pages#faq', via: 'get'
  match '/prevention' => 'static_pages#prevention', via: 'get'
  match '/links' => 'static_pages#links', via: 'get'
  match '/twitter' => 'static_pages#twitter', via: 'get'
  match '/rfid_tags' => 'static_pages#whitepaper', via: 'get'

  root 'static_pages#home'
end
