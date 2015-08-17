module KnowledgeNetStore
  class ApplicationController < ActionController::Base
    layout "knowledge_net_store/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end