module KnowledgeNetStore
  class Engine < ::Rails::Engine
    isolate_namespace KnowledgeNetStore
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
    end
  end
end