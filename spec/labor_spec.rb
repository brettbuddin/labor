require File.join(File.dirname(__FILE__), 'spec_helper')

describe Labor do
  describe :servers do
    it "assigns a single server" do
      Labor.servers = "10.0.0.1:4370"
      Labor.servers.should == "10.0.0.1:4370"
    end

    it "assigns a list of servers" do
      Labor.servers = ["10.0.0.1:4370", "10.0.0.2:4370"]
      Labor.servers.should == ["10.0.0.1:4370", "10.0.0.2:4370"]
    end
  end
end
