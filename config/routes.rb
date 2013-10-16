StolenBicycleRegistry::Application.routes.draw do

  devise_for :users
  resources :bicycles, except: [:index]

  match '/home' => 'static_pages#home', via: 'get'
  match '/about' => 'static_pages#about', via: 'get' 
  match '/philosophy' => 'static_pages#philosophy', via: 'get'
  match '/faq' => 'static_pages#faq', via: 'get'
  match '/prevention' => 'static_pages#prevention', via: 'get'
  match '/links' => 'static_pages#links', via: 'get'
  match '/rfid_tags' => 'static_pages#whitepaper', via: 'get'

  root 'static_pages#home'
end

