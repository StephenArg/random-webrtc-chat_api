Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  post 'conversations/find_open_room'
  post 'conversations/reopen'
  get 'conversations/credentials', to: 'conversations#get_credentials'

  get 'messages/create'

  post 'users/create'
  post 'users/login'
  post 'users/authenticate', to: 'users#authenticateJWT'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
