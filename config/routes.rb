Rails.application.routes.draw do
  root to: 'homes#top'
  get "home/about" => "homes#about"

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }

  resources:books
  resources :users,only:[:edit,:show,:index,:update]
end