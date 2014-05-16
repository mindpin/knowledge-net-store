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
end