module KnowledgeNetStore
  class Point
    include Mongoid::Document
    include Mongoid::Timestamps
    include KnowledgeNetStore::PointRelation

    field :name, :type => String
    field :desc, :type => String

    validates :name, :presence => true, :uniqueness => {:scope => :net_id}

    belongs_to :net, :class_name => 'KnowledgeNetStore::Net'
    
  end
end