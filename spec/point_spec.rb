require 'spec_helper'

describe KnowledgeNetStore::Point do
  before{
    @net = KnowledgeNetStore::Net.create!(:name => "js", :desc => "javascript 教程")
  }

  it{
    KnowledgeNetStore::Point.count.should == 0
  }

  it{
    p1 = @net.points.create!(:name => "1", :desc => "1desc")
    p1.reload
    p1.name.should == "1"
    p1.desc.should == "1desc"
    p1.net.should == @net
  }

end