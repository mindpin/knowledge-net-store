KnowledgeNetStore::Engine.routes.draw do
  resources :nets do
    resources :points
  end
  root 'nets#index'
  #root 'home#index'
end
