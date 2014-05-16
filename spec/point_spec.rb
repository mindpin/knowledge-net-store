require 'spec_helper'

describe KnowledgeNetStore::Point do
  before{
    @net = KnowledgeNetStore::Net.create!(:name => "js", :desc => "javascript 教程")
  }


  it{
    KnowledgeNetStore::Point.count.should == 0
    p1 = KnowledgeNetStore::Point.create!(:name => "1", :desc => "11", :net => @net)
    KnowledgeNetStore::Point.create!(:name => "2", :desc => "22", :net => @net, :parents => [p1])
    KnowledgeNetStore::Point.count.should == 2
    point_1 = KnowledgeNetStore::Point.first
    point_2 = KnowledgeNetStore::Point.last
    point_1.name.should == "1"
    point_1.desc.should == "11"
    point_1.net.should  == @net
    point_2.name.should == "2"
    point_2.desc.should == "22"
    point_2.net.should  == @net

    point_1.children.should == [point_2]
    point_2.parents.should == [point_1]
  }
end