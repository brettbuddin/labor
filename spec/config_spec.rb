require File.join(File.dirname(__FILE__), 'spec_helper')

describe Labor::Config do
  before(:each) do
    @config = Labor::Config.new
  end

  describe "config files" do
    it "can be loaded" do
      @config.load File.join(File.dirname(__FILE__), 'files', 'sample_config.rb')
      @config.get(:foo).should == "bar"
    end

    it "should provide in-line variables for set keys" do
      @config.instance_eval <<-CONFIG
        set :foo, "bar"
        set :i_am, "at the \#{foo}"
      CONFIG
      @config.get(:i_am).should == "at the bar"
    end
  end

  describe "write access" do
    it "provides access to a key" do
      @config.set(:foo, "bar")
      @config.get(:foo).should == "bar"
    end

    it "provides access to keys via bracket method" do
      @config[:foo] = "bar"
      @config.get(:foo).should == "bar"
    end

    it "allows deletion of a key" do
      @config.set(:foo, "a noob")
      @config.delete(:foo)
      @config.get(:foo).should be_nil
    end
  end

  describe "read access" do
    it "provides access to a key" do
      @config.set(:foo, "bar")
      @config.get(:foo).should == "bar"
    end

    it "provides access to keys via bracket method" do
      @config.set(:foo, "bar")
      @config[:foo].should == "bar"
    end

    it "provides access to keys using methods" do
      @config.set(:foo, "bar")
      @config.foo.should == "bar"
    end

    it "allows checking existence of a key" do
      @config.set(:foo, "bar")
      @config.exists?(:foo)
    end
  end

  it "have each defined" do
    @config.respond_to?(:each)
  end
  
  describe :grouping do
    before(:each) do
      @config.instance_eval <<-CONFIG
        group :test do
          set :foo, "bar"
          set :i_am, "at the \#{foo}"
        end
      CONFIG
    end

    it "can retreive a key from a group" do
      @config.get(:test).get(:foo).should == "bar"
    end

    it "can assign a key to a group" do
      @config.test[:omg] = "wtf"
      @config.get(:test).get(:omg).should == "wtf"
    end
  end
end
