require File.join(File.dirname(__FILE__), 'spec_helper')

describe Labor::Config do
  before(:each) do
    @config = Labor::Config.new
  end

  it "loads config from a file" do
    @config.load File.join(File.dirname(__FILE__), 'files', 'sample_config.rb')
    @config.get(:foo).should == "bar"
  end

  it "allows write access to a key" do
    @config.set(:foo, "bar")
    @config.get(:foo).should == "bar"
  end

  it "allows read access to a key" do
    @config.set(:foo, "bar")
    @config.get(:foo).should == "bar"
  end

  it "allows read access to keys via bracket method" do
    @config.set(:foo, "bar")
    @config[:foo].should == "bar"
  end


  it "allows write access to keys via bracket method" do
    @config[:foo] = "bar"
    @config.get(:foo).should == "bar"
  end

  it "allows deletion of a key" do
    @config.set(:foo, "a noob")
    @config.delete(:foo)
    @config.get(:foo).should be_nil
  end

  it "allows checking existence of a key" do
    @config.set(:foo, "bar")
    @config.exists?(:foo)
  end

  it "have each defined" do
    @config.respond_to?(:each)
  end

  it "allow configs to use keys as in-line variables" do
    @config.instance_eval <<-CONFIG
      set :foo, "bar"
      set :i_am, "at the \#{foo}"
    CONFIG
    @config.get(:i_am).should == "at the bar"
  end
end
