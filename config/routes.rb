Shmessage::Engine.routes.draw do
  resources :messages

  namespace :api do
    scope module: :v1, default: {format: :json} do
      put 'messages/:id/read', to: 'messages#read'
      resources :messages, only: [:show, :index, :create, :update, :destroy]
    end
  end
end
