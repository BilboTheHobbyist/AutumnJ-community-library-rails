Rails.application.routes.draw do
  resources :comments
  resources :books, only: [:show, :new, :create, :destroy]
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

  get '/books/:id/destroy', to: 'books#destroy'

  get '/books/:id/borrow', to: 'books#show_available_to_borrow', as:'view_borrowable_book'

  post '/books/:id/borrow', to: 'books#borrow_book', as:'borrow_book'

  get '/books/:id/borrowed', to: 'books#show_borrowed', as:'borrowed_book'

  post '/books/:id/return', to: 'books#return_book', as: 'return_book'

end
