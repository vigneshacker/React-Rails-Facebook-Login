Rails.application.routes.draw do
  post 'auth/facebook'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
