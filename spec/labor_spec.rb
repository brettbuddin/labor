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
  
  describe :configuration do
    before(:each) do
      Labor.config = File.join(File.dirname(__FILE__), 'files', 'sample_config.rb')
    end

    after(:each) do
      Labor.instance_variable_set(:@config, nil)
    end

    it "can instantiate the config object" do
      Labor.config.should be_instance_of(Labor::Config)
    end

    it "can retreive a key from the loaded config file" do
      Labor.config.foo.should == "bar"
    end
  end
end
