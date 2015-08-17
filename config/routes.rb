Rails.application.routes.draw do
  get 'users/:user_id/todos/incomplete', to: 'todos#incomplete'
    
  resources :users do
    resources :todos do
      member do
        put 'complete'
      end
    end
  end
end
