Rails.application.routes.draw do
  resources :comments
  resources :books
  resources :book_genres
  resources :book_authors
  resources :genres
  resources :authors
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  # devise_for :users, :controllers => { registrations: 'registrations' }

  # sets the index action for the home controller as the root path for a signed in user 
  # sets up the log in page as root path for an unauthenticated user

  authenticated :user do
    root 'home#index', as: 'authenticated_root'
  end

  devise_scope :user do
    root 'devise/sessions#new'
  end

end
