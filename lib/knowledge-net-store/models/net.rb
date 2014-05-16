module KnowledgeNetStore
  class Net
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :desc, :type => String
  end
end