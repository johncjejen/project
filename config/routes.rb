Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  #devise_for :users, :controllers => { registrations: 'users/registrations' }
  #devise_for :users, path: "auth", :controllers => {sessions: 'sessions', registrations: 'registrations', confirmations: 'confirmations', passwords: 'passwords', omniauth_callbacks: 'omniauth_callbacks'} 
  get "index/index"

  root :to => "index#index"

end
