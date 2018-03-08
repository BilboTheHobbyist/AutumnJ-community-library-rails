Rails.application.routes.draw do
  resources :comments
  resources :books, only: [:show, :new, :create]
  resources :book_genres
  resources :book_authors
  resources :genres
  resources :authors
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  # sets the index action for the home controller as the root path for a signed in user 
  # sets up the log in page as root path for an unauthenticated user

  authenticated :user do
    root 'home#index', as: 'authenticated_root'
  end

  devise_scope :user do
    root 'devise/sessions#new'
  end

end
