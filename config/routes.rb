Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints subdomain: 'ruby' do
    get 'signup',     to: 'users#new'
    get 'login',      to: 'sessions#new'
    post 'login',     to: 'sessions#create'
    delete 'logout',  to: 'sessions#destroy'
    get '/',          to: 'pages#ruby_index'

    resources :articles
    resources :users, except: [:new]
  end

  root 'pages#index'
end
