module KnowledgeNetStore
  class Point
    include Mongoid::Document
    include Mongoid::Timestamps
    include ActsAsDag

    field :name, :type => String
    field :desc, :type => String

    validates :name, :presence => true, :uniqueness => {:scope => :net_id}

    belongs_to :net, :class_name => 'KnowledgeNetStore::Net'
    
    def attrs
      {
        id: self.id.to_s,
        net_id: self.net.id.to_s,
        name: self.name,
        desc: self.desc,
        created_at: self.created_at.to_s,
        updated_at: self.updated_at.to_s
      }
    end
  end
end
