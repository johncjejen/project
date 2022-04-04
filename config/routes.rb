Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  #devise_for :users, :controllers => { registrations: 'users/registrations' }
  #devise_for :users, path: "auth", :controllers => {sessions: 'sessions', registrations: 'registrations', confirmations: 'confirmations', passwords: 'passwords', omniauth_callbacks: 'omniauth_callbacks'} 
  get "index/index"

  root :to => "index#index"

  post "posts/create" => 'posts#create'
  get "posts/export_post", to: "posts#export_post"

  get "posts/new" => 'posts#new'
  get "posts/index" => 'posts#index'
  get "posts/my_post" => 'posts#my_post'
  get "posts/view_post/:id" => 'posts#view_post'
  get 'posts/:id', to: "posts#edit"

end
