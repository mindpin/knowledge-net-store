module KnowledgeNetStore
  class Engine < ::Rails::Engine
    isolate_namespace KnowledgeNetStore
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper

      Dir.glob(Rails.root + "app/decorators/knowledge_net_store/**/*_decorator.rb").each do |c|
        require_dependency(c)
      end

    end
  end
end
