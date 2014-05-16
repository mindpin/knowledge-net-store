module KnowledgeNetStore
  class Point
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :desc, :type => String

    belongs_to :net, :class_name => 'KnowledgeNetStore::Net'
    has_and_belongs_to_many :parents,
      :class_name => 'KnowledgeNetStore::Point',
      :inverse_of => :children
    has_and_belongs_to_many :children,
      :class_name => 'KnowledgeNetStore::Point',
      :inverse_of => :parents
  end
end