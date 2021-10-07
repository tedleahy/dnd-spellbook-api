Rails.application.routes.draw do
  post '/spells', to: 'spells#index'
  get 'spells/:id', to: 'spells#show'
end
