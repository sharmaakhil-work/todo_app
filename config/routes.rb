Rails.application.routes.draw do
  resources :todos do
    member do
      patch :update_status
    end
  end
  
  root 'todos#index'
end