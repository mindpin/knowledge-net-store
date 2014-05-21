require 'spec_helper'

describe KnowledgeNetStore::Net do
  it{
    KnowledgeNetStore::Net.count.should == 0
    KnowledgeNetStore::Net.create!(:name => "js", :desc => "javascript 教程")
    KnowledgeNetStore::Net.count.should == 1
    net = KnowledgeNetStore::Net.last
    net.name.should == "js"
    net.desc.should == "javascript 教程"
  }

  it{
    json = IO.read(File.expand_path("../js.json",__FILE__))
    KnowledgeNetStore::Net.from_json("js","js blanblan", json)
    KnowledgeNetStore::Net.count.should == 1
    KnowledgeNetStore::Point.count.should == 93

    net = KnowledgeNetStore::Net.last
    json = net.to_json
    json.should_not == ""
  }
end