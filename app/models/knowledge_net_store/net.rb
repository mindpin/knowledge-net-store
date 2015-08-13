require 'json'

module KnowledgeNetStore
  class Net
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, :type => String
    field :desc, :type => String

    validates :name, :presence => true, :uniqueness => true

    has_many :points, :class_name => 'KnowledgeNetStore::Point'

    def to_json
      points_hash = []
      edges_hash  = []

      self.points.each do |point|
        point_hash = {:id => point.id.to_s, :name => point.name, :desc => point.desc}
        points_hash << point_hash
        point.parents.each do |parent|
          edge_hash = {:parent => parent.id.to_s, :child => point.id.to_s}
          edges_hash << edge_hash
        end
      end

      {
        "points" => points_hash,
        "edges"  => edges_hash
      }.to_json
    end

    def attrs
      {
        id: self.id.to_s,
        name: self.name,
        desc: self.desc,
        point_ids: self.point_ids.map(&:to_s),
        created_at: self.created_at.to_s,
        updated_at: self.updated_at.to_s
      }
    end

    def self.from_json(name, desc, json)
      net = self.create!(:name => name, :desc => desc)
      hash = JSON.parse(json)
      id_point_hash = {}
      hash["points"].each do |point_hash|
        point = net.points.create!(:name => point_hash["name"], :desc => point_hash["desc"])
        id_point_hash[point_hash["id"]] = point
      end
      hash["edges"].each do |edge_hash|
        parent = id_point_hash[edge_hash["parent"]]
        child  = id_point_hash[edge_hash["child"]]
        next if parent == child
        child.add_parent parent
      end
      net
    rescue Exception => ex
      net.destroy if !net.blank?
    end
  end
end
