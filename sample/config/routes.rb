Rails.application.routes.draw do
  mount KnowledgeNetStore::Engine => '/', :as => 'knowledge_net_store'
  mount PlayAuth::Engine => '/auth', :as => :auth
end
