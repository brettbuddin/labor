require File.join(File.dirname(__FILE__), 'spec_helper')

class Test
  def self.perform
    puts "Hello"
  end
end

describe Labor::Worker do
  before(:each) do
    @worker = Labor::Worker.new 'test'
  end

  it "assigns abilities" do
    real_worker = @worker.instance_variable_get(:@worker)
    real_worker.instance_variable_get(:@abilities).should have_key("test")
  end
end
