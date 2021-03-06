StolenBicycleRegistry::Application.routes.draw do
  root 'static_pages#home'

  match '/search', to: 'bicycles#index', via: 'get'
  match '/home' => 'static_pages#home', via: 'get'
  match '/about' => 'static_pages#about', via: 'get'
  match '/philosophy' => 'static_pages#philosophy', via: 'get'
  match '/faq' => 'static_pages#faq', via: 'get'
  match '/prevention' => 'static_pages#prevention', via: 'get'
  match '/links' => 'static_pages#links', via: 'get'
  match '/twitter' => 'static_pages#twitter', via: 'get'
  match '/rfid_tags' => 'static_pages#whitepaper', via: 'get'
  match '/api_doc' => 'static_pages#api', via: 'get'
  match '/team_epicodus' => 'static_pages#team_epicodus', via: 'get'

  devise_for :users, :controllers => { :registrations => :registrations }
  devise_scope :user do
    match 'sign_in', to: 'devise/sessions#new', via: 'get'
    match 'sign_out', to: 'devise/sessions#destroy', via: 'get'
    match 'sign_up', to: 'registrations#new', via: 'get'
  end

  namespace :api, :defaults => { :format => :json } do
    namespace :v1 do
      resources :bicycles, only: [:index, :create]
      resources :users, only: :create
    end
  end

  resources :bicycles
  resources :imports, only: [:create, :new] 
  resources :users, only: [:show, :index]
end
